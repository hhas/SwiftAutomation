//
//  AppleEventDescriptor.swift
//  SwiftAutomation
//


import Foundation



public class AppleEventDescriptor: CustomDebugStringConvertible, SelfPacking, SelfUnpacking {
    
    // memory-managed AEDesc; use `AppleEventDescriptor.desc` to access underlying AEDesc; caution: 1. desc is only valid until AppleEventDescriptor instance is dealloced; 2. client code must not dispose desc itself // TO DO: would be safer to make desc slot private and only expose through `withRawDesc` block
    
    public var debugDescription: String {
        return "<AppleEventDescriptor \(formatFourCharCodeLiteral(self.desc.descriptorType))>"
    }
    
    public private(set) var desc = nullDescriptor
    private let isOwner: Bool
    
    convenience public init() {
        self.init(desc: nullDescriptor, isOwner: false) // no disposal needed as dataHandle is nil
    }
    
    required public init(desc: AEDesc, isOwner: Bool = true) {
        self.desc = desc
        self.isOwner = isOwner
    }
    
    deinit {
        if self.isOwner { AEDisposeDesc(&self.desc) }
    }
    
    // TO DO: what, if any, methods should be implemented here?
    
    public func coerce(to descriptorType: DescType) throws -> AppleEventDescriptor {
        return try AppleEventDescriptor(desc: self.desc.coerce(to: descriptorType))
    }
    
    public func copy() -> AppleEventDescriptor {
        return AppleEventDescriptor(desc: self.desc.copy())
    }
    
    //
    
    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> AEDesc { // TO DO: ownership? (problem is that Specifier, Symbol, AppleEventDescriptor are returning existing cached AEDesc whereas Array, Dictionary, Set return newly created AEDesc); for now, safest to copy cached descs before returning
        return self.desc.copy()
    }
    static public func SwiftAutomation_unpackSelf(_ desc: AEDesc, appData: AppData) throws -> Self {
        return self.init(desc: desc)
    }
    
    static public func SwiftAutomation_noValue() throws -> Self {
        return self.init(desc: nullDescriptor)
    }

}
