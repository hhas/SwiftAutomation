#!/usr/bin/python
# -*- coding: utf-8 -*-

""" aeglue -- Generate Swift application glues for SwiftAE; requires AppleEventBridge framework (https://bitbucket.org/hhas/appleeventbridge/) built and installed in ~/Library/Frameworks """

# ../aeglue -dr; ../aeglue -r TextEdit; ../aeglue -rs Finder; ../aeglue -r iTunes

# TO DO: this is temporary until aete/sdef parsing is ported from AEB to SwiftAE, at which point it can be recoded in Swift


import getopt, os, re, string, sys
import xml.etree.ElementTree as ET

import objc # (this script uses system Python, which includes PyObjC as standard)
from Foundation import NSObject, NSBundle, NSURL

kFrameworkName = 'SwiftAE'


######################################################################
# IMPORT AEB FRAMEWORK
######################################################################

kAEBFrameworkName = 'AppleEventBridge'

aebpath = os.path.expanduser('~/Library/Frameworks/%s.framework' % kAEBFrameworkName)
if not os.path.isdir(aebpath):
    print >> sys.stderr, '%s not found.' % aebpath
    sys.exit(1)
kAEBBundle = objc.loadBundle(kAEBFrameworkName, globals(), bundle_path=aebpath)

kFrameworkVersion =  kAEBBundle.infoDictionary()['CFBundleShortVersionString']


######################################################################
# UTILITIES
######################################################################


def shquote(s):
    return s if re.match('^[a-zA-Z0-9_.-]+$', s) else "'" + s.replace("'", "'\\''") + "'"


def writefile(path, s):
    with open(path, 'w') as f:
        f.write(s.encode('utf-8'))

def readfile(path):
    with open(path) as f:
        return f.read().decode('utf-8')

def readtemplate(name, suffix='txt'):
    #path = kAEBBundle.pathForResource_ofType_inDirectory_(name, suffix, u'templates')
    path = os.path.join(os.path.dirname(__file__), 'SwiftAE/SwiftAEGlueTemplate.txt') # temp kludge to find template relative to aeglue in xcode project
    if not path:
        raise ValueError("Can't find template: %s" % name)
    return readfile(path)


######################################################################
# SDEF EXPORTER
######################################################################

# TO DO: make sure app terms that conflict with builtins are escaped correctly


def exportsdef(appurl, outpath, keywordconverter, prefix, allowoverwrite):
    """ Export application's .sdef file as user documentation. Keywords are reformatted as appropriate. 
    
        outpath : str -- glue path with .sdef prefix
    """
    def convertnode(node, attrname, suffix='', prefix=''):
        attr = node.get(attrname)
        if attr: node.set(attrname, prefix+keywordconverter.convertSpecifierName_(attr)+suffix)
    sdef = AEBDynamicSDEFParser.copyScriptingDefinitionAtURL_error_(appurl, None)
    if not sdef:
        raise ValueError("Can't export SDEF for %r: %s" % (appurl,  "can't get terminology."))
    root = ET.XML(str(sdef))
    symbolnamespace = '%s.' % prefix
    for suite in root.findall('./suite'):
        for key in ['command', 'event']:
            for command in suite.findall(key):
                convertnode(command, 'name')
                for param in command.findall('parameter'):
                    attr = param.get('name')
                    if attr: param.set('name', keywordconverter.convertSpecifierName_(attr)+':')
        for key in ['class', 'class-extension', 'record-type']:
            for klass in suite.findall(key):
                convertnode(klass, 'name')
                # optional plural names require extra fiddling
                pluralname = klass.get('plural')
                if not pluralname:
                    pluralname = klass.get('name')
                    if pluralname:
                        pluralname += 's'
                if pluralname:
                    klass.set('plural', pluralname)
                for elem in klass.findall('element'):
                    convertnode(elem, 'type')
                for prop in klass.findall('property'):
                    convertnode(prop, 'name')
                cont = klass.find('contents')
                if cont is not None and cont.get('name'):
                    convertnode(cont, 'name')
                for resp in klass.findall('responds-to'):
                    convertnode(resp, 'name')
                    convertnode(resp, 'command')
        for enumeration in suite.findall('enumeration'):
            for enum in enumeration.findall('enumerator'):
                convertnode(enum, 'name', prefix=symbolnamespace)
        for value in suite.findall('value-type'):
            convertnode(value, 'name')
    if not os.path.exists(outpath) or allowoverwrite:
        ET.ElementTree(root).write(outpath, encoding="utf-8", xml_declaration=True)
        print >> sys.stdout, outpath
    else:
        print >> sys.stderr, "Couldn't write file to path as it already exists:", outpath


######################################################################
# GLUE RENDERER
######################################################################


def insert(tpl, label, content): # replace all tags with given name
    return tpl.replace(u'«{}»'.format(label), content)

def repeat(tpl, label, contentlist, renderer, default=''): # find and render all NEW...END blocks with given name (note: identically named blocks can contain same or different placeholder content, but all will be rendered with same data and renderer callback)
    # caution: names within inner repeat blocks must be different to names in outer repeat blocks
    # caution: when replacing multiple blocks with the same label, contentlist must be a list, not a generator (otherwise only the first block will render)
    def insertblock(m):
        subtpl = m.group(1).rstrip()
        return u''.join(renderer(subtpl, content) for content in contentlist) if contentlist else default
    return re.sub(u'(?s)\\n?«\\+%s»(.*?)«-%s»' % (label, label), insertblock, tpl)

def omit(tpl, label, delete):
    return re.sub(u'(?s)\\n?«\\+%s»(.*?)«-%s»' % (label, label), '' if delete else '\\1', tpl)

# TO DO: merge fcc, fccstr and try caching results if speed on large dictionaries is an issue

def fcc(code): # format OSType as hex int
    return u'0x%08x' % code

def fccstr(code): # format OSType as str
    s = ''
    for _ in range(1,5):
        code, o = divmod(code, 256)
        s = (chr(o) if (32 <= o < 127 and o != 39 and o != 92) else '\\x%02x' % o) + s
    return s


def insertcodeandname(tpl, content):
    (code, name) = content
    tpl = insert(tpl, 'NAME', name)
    tpl = insert(tpl, 'CODE_STR', fccstr(code))
    return insert(tpl, 'CODE', fcc(code))

def insertcommand(tpl, term):
    tpl = insert(tpl, 'COMMAND_NAME', term.name())
    tpl = insert(tpl, 'CAP_NAME', term.name()[0].upper()+term.name()[1:])
    eventclass, eventid = term.eventClass(), term.eventID()
    tpl = insert(tpl, 'EVENT_CLASS_STR', fccstr(eventclass))
    tpl = insert(tpl, 'EVENT_CLASS', fcc(eventclass))
    tpl = insert(tpl, 'EVENT_ID_STR', fccstr(eventid))
    tpl = insert(tpl, 'EVENT_ID', fcc(eventid))
    return repeat(tpl, 'PARAMETER', [(p.code(), p.name()) for p in term.parameters()], insertcodeandname)


kElement = 1
kProperty = 3
kCommand = 4

kType = 0x74797065
kEnum = 0x656e756d

def renderglue(tpl, outdir, gluesourcefilename, appinfo, terms, allowoverwrite, shellcmd):
    """
        tpl : str -- template
        outdir : str -- path to directory into which this file will be written
        gluesourcefilename : str -- the name of the file to be written
        appinfo : AppInfo -- general information, if any, on application
        terms : AEBDynamicTerminology
    """
    # insert general info
    tpl = insert(tpl, 'PREFIX', appinfo.prefix)
    tpl = insert(tpl, 'GLUE_NAME', gluesourcefilename)
    tpl = insert(tpl, 'FRAMEWORK_NAME', kFrameworkName+'.framework')
    tpl = insert(tpl, 'FRAMEWORK_VERSION', kFrameworkVersion)
    tpl = insert(tpl, 'APPLICATION_CLASS_NAME', appinfo.appclassname)
    tpl = insert(tpl, 'AEGLUE_COMMAND', shellcmd)
    # include application info, if relevant
    tpl = insert(tpl, 'APPLICATION_NAME', appinfo.filename or '')
    tpl = insert(tpl, 'APPLICATION_VERSION', appinfo.version or '')
    tpl = insert(tpl, 'BUNDLE_IDENTIFIER', appinfo.bundleid or '')
    tpl = omit(tpl, 'DEFAULT_INIT', not appinfo.bundleid)
    # insert name-code mappings
    # [(str, AEBDynamicTerm),...]
    specifierbyname = sorted(terms.specifiersByName().items(), key=lambda o: o[0]) # selectors, raw constants
    # [((code: int, name: str), desctype: int),...]
    typebyname = sorted((((desc.typeCodeValue(), name), desc.descriptorType()) 
            for name, desc in terms.typesByName().items()), key=lambda o: o[0][1]) # symbol contructors, raw constants
    # [(code: int, name: str),...]
    typebycode = sorted(terms.typesByCode().items(), key=lambda o: o[1]) # symbol lookup
    propertybycode = sorted(terms.propertiesByCode().items(), key=lambda o: o[1])
    elementbycode = sorted(terms.elementsByCode().items(), key=lambda o: o[1])
    for label, contentlist, default in [
            ('PROPERTY_FORMATTER', propertybycode, ':'),
            ('ELEMENTS_FORMATTER', elementbycode, ':'),
            ('SYMBOL_SWITCH', typebycode, ''),
            ('TYPE_SYMBOL', (v for v, desctype in typebyname if desctype == kType), ''),
            ('ENUM_SYMBOL', (v for v, desctype in typebyname if desctype == kEnum), ''),
            ('PROPERTY_SPECIFIER', ((t.code(), t.name()) for name, t in specifierbyname if t.kind() == kProperty), ''),
            ('ELEMENTS_SPECIFIER', ((t.code(), t.name()) for name, t in specifierbyname if t.kind() == kElement), '')]:
        tpl = repeat(tpl, label, contentlist, insertcodeandname, default)
    tpl = repeat(tpl, 'COMMAND', [t for name, t in specifierbyname if t.kind() == kCommand], insertcommand)
    outpath = os.path.join(outdir, gluesourcefilename)
    if not os.path.exists(outpath) or allowoverwrite:
        writefile(outpath, tpl)
        print >> sys.stdout, outpath
    else:
        print >> sys.stderr, "Couldn't write file to path as it already exists (use -r to overwrite):", outpath

    


######################################################################
# MAKE GLUE
######################################################################

# TO DO: also need to generate constants file[s] (Q. what about AEBSwiftSymbol? should that also be autogenerated each time? if so, need to check how best to get and process AS's terminology)
# TO DO: messy; restructure: AppInfo should contain app info only; language-specific info/APIs should be in separate (wrapper) classes

class AppInfo:
    def __init__(self, appurl=None, prefix=None, appclassname=None, isobjc=False, usesdef=False):
        self.appurl, self.isobjc, self.usesdef = appurl, isobjc, usesdef
        self.keywordconverter = (AEBObjCKeywordConverter if isobjc else AEBSwiftKeywordConverter).sharedKeywordConverter()
        if appurl:
            appbundle = NSBundle.bundleWithURL_(appurl)
            if not appbundle:
                raise ValueError(u'Not a valid bundle: %s' % appurl)
            appinfo = dict(appbundle.infoDictionary() if appbundle else {})
            self.filename = appurl.lastPathComponent()
            self.name = appinfo.get('CFBundleName')
            self.version = appinfo.get('CFBundleShortVersionString')
            self.bundleid = appinfo.get('CFBundleIdentifier')
            self.prefix = prefix or self.keywordconverter.prefixForAppName_(self.name or 'UNKNOWN')
        else:
            self.filename = ''
            self.name, self.version, self.bundleid, self.prefix = 'AEApplication', '', '', 'AE'
        self.appclassname = self.keywordconverter.identifierForAppName_(appclassname or self.name or self.prefix+'Application')
        if self.appclassname == self.prefix:
            raise ValueError("-n CLASSNAME and -p PREFIX options cannot be the same: %s" % name)
        self.gluename = self.appclassname + 'Glue'

    def terminology(self):
        appdata = AEBDynamicAppData.alloc().initWithApplicationURL_useSDEF_keywordConverter_(
            self.appurl, self.usesdef, self.keywordconverter)
        terms = appdata.terminologyWithError_(None)
        if not terms:
            raise ValueError("Can't get terminology for: %s" % appurl)
        return terms

    def makeglue(self, outdir, allowoverwrite, shellcmd):
        terms = self.terminology()
        renderglue(readtemplate('SwiftAEGlueTemplate'), outdir, self.gluename+'.swift', self, terms, allowoverwrite, shellcmd)
        if self.appurl:
            exportsdef(self.appurl, os.path.join(outdir, '%s.swift.sdef' % self.gluename),
                       self.keywordconverter, self.prefix, allowoverwrite)



######################################################################
# MAIN
######################################################################


if __name__ == '__main__':
    try:
        import time; tt = time.time() # DEBUG
        kOpts = 'dhn:op:rsv'
        opts, args = getopt.getopt(sys.argv[1:], kOpts) # TO DO: language option (default=swift)
        opts = dict(opts)
        if (not args and '-d' not in opts) or '-h' in opts:
            print >> sys.stderr, "Generate Swift/Objective-C application glues for AppleEventBridge."
            print >> sys.stderr
            print >> sys.stderr, "Usage:"
            print >> sys.stderr
            print >> sys.stderr, "    aeglue [-n CLASSNAME] [-p PREFIX] [-r] [-s] APPNAME [OUTDIR]"
            print >> sys.stderr, "    aeglue -d [-r] [OUTDIR]"
            print >> sys.stderr, "    aeglue [-h] [-v]"
            print >> sys.stderr
            print >> sys.stderr, "APPPATH - Name or path to application."
            print >> sys.stderr
            print >> sys.stderr, "OUTDIR - Path to directory in which the glue files will be created;"
            print >> sys.stderr, "           if omitted, the current working directory is used."
            print >> sys.stderr
            print >> sys.stderr, "On completion, the generated files' paths are written to STDOUT."
            print >> sys.stderr
            print >> sys.stderr, "Options:"
            print >> sys.stderr
            print >> sys.stderr, "    -d             Generate glue using default terminology only"
            print >> sys.stderr, "    -h             Show this help and exit"
            print >> sys.stderr, "    -n CLASSNAME   Application class name as a C-style identifier;"
            print >> sys.stderr, "                     if omitted, a default name is auto-generated"
            print >> sys.stderr, "    -p PREFIX      Class names prefix; if omitted, a default "
            print >> sys.stderr, "                     3-character prefix is auto-generated"
            print >> sys.stderr, "    -r             If a file already exists, replace it"
            print >> sys.stderr, "    -s             Use SDEF terminology instead of AETE, e.g. if"
            print >> sys.stderr, "                     application's ascr/gdte handler is broken"
            print >> sys.stderr, "    -v             Output AppleEventBridge framework's version and exit"
            print >> sys.stderr
            print >> sys.stderr, "Examples:"
            print >> sys.stderr
            print >> sys.stderr, "    aeglue TextEdit"
            print >> sys.stderr
            print >> sys.stderr, "    aeglue iTunes"
            print >> sys.stderr
            print >> sys.stderr, "    aeglue -s Finder"
            print >> sys.stderr
            print >> sys.stderr, "    aeglue -p TE TextEdit ~/Documents"
            print >> sys.stderr
            sys.exit()
        isobjc = False
        if '-v' in opts:
            print >> sys.stdout, kFrameworkVersion
            sys.exit()
        if '-d' in opts: # use default terms only
            if len(args) == 0:
                outdir = os.getcwd()
            elif len(args) == 1:
                outdir = args[-1]
            else:
                raise ValueError('Wrong number of arguments.')
            appinfo = AppInfo(isobjc=isobjc)
        else: # use terms from specified application, plus default terms
            if len(args) == 1:
                outdir = os.getcwd()
            elif len(args) == 2:
                outdir = args[-1]
            else:
                raise ValueError('Wrong number of arguments.')
            appname = args[0]
            if appname.startswith('~/'):
                appname = os.path.expanduser(appname)
            appurl = AEMApplication.fileURLForApplicationWithName_(appname)
            if not appurl:
                raise ValueError("Can't find application: %s" % appname)
            appinfo = AppInfo(appurl, opts.get('-p'), opts.get('-n'), isobjc, '-s' in opts)
            if not appinfo.bundleid:
                print >> sys.stderr, "Warning: default constructor not supported as bundle identifier not found."
        outdir = os.path.abspath(os.path.expanduser(outdir))
        if not os.path.exists(outdir):
            parentdir = os.path.dirname(outdir)
            if not os.path.isdir(parentdir):
                raise ValueError("Not a valid output directory: %s" % outdir)
            os.mkdir(outdir)
            print >> sys.stderr, "Created output directory:", outdir
        elif not os.path.isdir(outdir):
            raise ValueError("Not a valid output directory: %s" % outdir)
        # TO DO: copy SwiftAE files; TO DO: get rid of this once Swift frameworks are fully supported
#       for name in ['SwiftAEGlueBase', 'SwiftAEFormatter', 'SwiftAETranslate']:
#           writefile(os.path.join(os.path.join(outdir, name+'.swift')), readtemplate(name, 'swift'))
        # generate glue files
        shellcmd = 'aeglue %s' % (' '.join([('%s %s' % (k, shquote(v) if k[1]+':' in kOpts else '')).strip() for k, v in opts.items()]
                                            + [shquote(os.path.basename(arg)) for arg in args]))
        appinfo.makeglue(outdir, '-r' in opts, shellcmd)
        print >> sys.stderr, "Created %s (%ims)" % (appinfo.gluename, (time.time()-tt)*1000) # DEBUG
    except Exception, e:
        print >> sys.stderr, "Error:", e
        import traceback; traceback.print_exc() # DEBUG
        sys.exit(1)




