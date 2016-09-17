//
//  SAEFormatter.swift
//  AppleScriptToSwift
//
//  Swift-ObjC shim
//
//

import Foundation

import SwiftAutomation


@objc public class SAEFormatter: NSObject {
    @objc public class func formatAppleEvent(_ event: NSAppleEventDescriptor, useSDEF: Bool) -> String {
        return SwiftAutomation.formatAppleEvent(descriptor: event, useTerminology: (useSDEF ? .sdef : .aete))
    }
}


