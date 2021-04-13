//
//  File.swift
//  
//
//  Created by Aaron Hinton on 4/11/21.
//

import Foundation
import Vapor

struct List {
    static func list() -> DeviceList {
        let simulatorOutput = shell("xcrun simctl list --json")
        let decoder = JSONDecoder()
        let product = try! decoder.decode(DeviceList.self, from: simulatorOutput.data(using: .utf8)!)
        return product
    }
}

struct DeviceList: Content {
    var devicetypes: [DeviceType]
    var runtimes: [Runtime]
    var devices: [String: [Device]]
    var pairs: [String: Pair]
}

struct DeviceType: Content {
    var minRuntimeVersion: Int
    var bundlePath: String
    var maxRuntimeVersion: Int
    var name: String
    var identifier: String
    var productFamily: String
}

struct Runtime: Content {
    var bundlePath: String
    var buildversion: String
    var runtimeRoot: String
    var identifier: String
    var version: String
    var isAvailable: Bool
    var name: String
}

struct Device: Content {
    var availabilityError: String?
    var dataPath: String
    var logPath: String
    var udid: String
    var isAvailable: Bool
    var deviceTypeIdentifier: String?
    var state: String
    var name: String
}

struct Pair: Content {
    var watch: Watch
    var phone: Phone
    var state: String
}

struct Watch: Content {
    var name: String
    var udid: String
    var state: String
}

struct Phone: Content {
    var name: String
    var udid: String
    var state: String
}
