//
//  TestHelper.swift
//  
//
//  Created by Aaron Hinton on 4/22/21.
//

import Foundation
@testable import App
import XCTVapor

typealias DeviceName = String

enum TestDevice {
    case test(String? = nil)
    case testAppInfo
    case testBooted
    case testCreate
    case testDevice(String)
    case testOpenURL
    case testRenamed
    
    static let prefix = "test"
    
    var name: DeviceName {
        switch self {
        case .test(let id):
            if let id = id {
                return "test\(id)"
            }
            return "test"
        case .testAppInfo:
            return "testappinfo"
        case .testBooted:
            return "testbooted"
        case .testCreate:
            return "testcreate"
        case .testDevice(let name):
            return name
        case .testOpenURL:
            return "testopenurl"
        case .testRenamed:
            return "testrenamed"
        }
    }
}

struct TestHelper {
    static let appleWatchDevices = 4
    static let iPadDevices = 4
    static let iPhoneDevices = 10

    private static let queue = DispatchQueue(label: "TestHelper")
    
    static func bootSimulator(app: Application, device: TestDevice) throws {
        let url = try URLHelper.escape(url: "boot/\(device.name)")
        try app.test(.POST, url, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
    
    static func createDefaultSimulators(app: Application) throws {
        let deviceTypes = try getDefaultDeviceTypes(app: app)
        let simulators: [Simulator] = deviceTypes.map { (device) -> Simulator in
            return Simulator(device: .testDevice(device.name), type: .custom(device.name))
        }
        try createTestSimulators(app: app, simulators: simulators)
    }
    
    static func createTestSimulators(app: Application, simulators: [Simulator]) throws {
        for simulator in simulators {
            let path = try URLHelper.escape(url: "create/\(simulator.device.name)/\(simulator.type.name)")
            try app.test(.POST, path, afterResponse: { res in
                XCTAssertEqual(res.status, .ok)
            })
        }
    }
    
    static func deleteAllSimulators(app: Application) throws {
        let path = try URLHelper.escape(url: "delete/all")
        try app.test(.POST, path, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
    
    static func deleteTestSimulators(app: Application, simulators: [Simulator]) throws {
        for simulator in simulators {
            while try Self.deviceExists(app: app, named: simulator.device) {
                let path = try URLHelper.escape(url: "delete/\(simulator.device.name)")
                try app.test(.POST, path, afterResponse: { res in
                    XCTAssertEqual(res.status, .ok)
                })
                sleep(1)
            }
        }
    }
    
    static func deviceExists(app: Application, named name: TestDevice) throws -> Bool {
        let devices = try Self.getDevices(app: app)
        return devices.contains { (device) -> Bool in
            return device.name == name.name
        }
    }
    
    static func filterDeviceTypes(deviceTypes: [DeviceType]) throws -> [ProductFamily: [DeviceType]] {
        var productFamilies: [ProductFamily: [DeviceType]] = [:]
        
        for deviceType in deviceTypes {
            guard let productFamily = ProductFamily.init(rawValue: deviceType.productFamily) else {
                throw SimctlError.error("Could not resolve product family for \(deviceType.productFamily)")
            }
            if let _ = productFamilies[productFamily] {
                productFamilies[productFamily]?.append(deviceType)
            } else {
                productFamilies[productFamily] = [deviceType]
            }
        }
        
        return productFamilies
    }
    
    static func getAvailableRuntimes(app: Application) throws -> [RuntimeOS: String] {
        var runtimes: [RuntimeOS: String] = [:]
        try app.test(.GET, "list/runtimes", afterResponse: { res in
            if let runtimesResponse = try? res.content.decode([Runtime].self) {
                for runtime in runtimesResponse {
                    if let appRuntime = RuntimeOS.getRuntimeOS(runtime: runtime.name) {
                        runtimes[appRuntime] = runtime.name.replacingOccurrences(of: " ", with: "")
                    }
                }
            }
        })
        return runtimes
    }
    
    static func getDefaultDeviceTypes(app: Application) throws -> [DeviceType] {
        let deviceTypes = try getDeviceTypes(app: app)
        let filteredDevices = try filterDeviceTypes(deviceTypes: deviceTypes)
        var devices: [DeviceType] = []
        
        if let appleWatch = filteredDevices[.appleWatch] {
            if appleWatch.count <= appleWatchDevices {
                devices.append(contentsOf: appleWatch)
            } else {
                devices.append(contentsOf: appleWatch.suffix(from: appleWatch.count - appleWatchDevices))
            }
        }
        if let appleTV = filteredDevices[.appleTV] {
            devices.append(contentsOf: appleTV)
        }
        if let iPhones = filteredDevices[.iPhone] {
            if iPhones.count <= iPhoneDevices {
                devices.append(contentsOf: iPhones)
            } else {
                devices.append(contentsOf: iPhones.suffix(from: iPhones.count - iPhoneDevices))
            }
        }
        if let iPads = filteredDevices[.iPad] {
            if iPads.count <= iPadDevices {
                devices.append(contentsOf: iPads)
            } else {
                devices.append(contentsOf: iPads.suffix(from: iPads.count - iPadDevices))
            }
        }
        return devices
    }
    
    static func getDevices(app: Application) throws -> [Device] {
        var simulators: [Device] = []
        try app.test(.GET, "list/devices", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            if let devices = try? res.content.decode([String: [Device]].self) {
                simulators = devices.flatMap({ $0.value })
            }
        })
        return simulators
    }
    
    static func getDeviceTypes(app: Application) throws -> [DeviceType] {
        var deviceTypes: [DeviceType] = []
        try app.test(.GET, "list/devicetypes", afterResponse: { res in
            if let decodedDeviceTypes = try? res.content.decode([DeviceType].self) {
                deviceTypes = decodedDeviceTypes
            }
        })
        return deviceTypes
    }
    
    static func removeTestSimulators(app: Application, prefix: String = "test") throws {
        let devices = try getDevices(app: app)
        for device in devices {
            if device.name.hasPrefix(prefix) {
                let simulator = Simulator(device: .testDevice(device.name), type: .custom(""))
                try deleteTestSimulators(app: app, simulators: [simulator])
            }
        }
    }
    
    static func shutdownSimulator(app: Application, simulator: Simulator) throws {
        let url = try URLHelper.escape(url: "shutdown/\(simulator.device.name)")
        try app.test(.POST, url, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
    
    static func waitUntilBooted(app: Application, device: TestDevice, timeout: TimeInterval = 60) throws {
        let start = Date()

        while Date().timeIntervalSince(start) < timeout {
            let createdDevice = try Self.getDevices(app: app).first(where: { $0.name == device.name })
            if createdDevice == nil {
                throw TestHelperError.deviceNotCreated
            }
            if createdDevice?.state == "Booted" {
                return
            }
            sleep(1)
        }
        throw TestHelperError.notBooted
    }
}

enum TestHelperError: Error {
    case deviceNotCreated
    case notBooted
}
