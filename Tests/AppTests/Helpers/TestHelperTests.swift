//
//  File.swift
//  
//
//  Created by Aaron Hinton on 4/24/21.
//

import Foundation
@testable import App
import XCTVapor

final class TestHelperTests: XCTestCase {
    var app: Application!
    
    override func setUpWithError() throws {
        app = Application(.testing)
        try configure(app)
    }
    
    override func tearDownWithError() throws {
        app.shutdown()
    }
    
    func testBootSimulator() throws {
        let device = ("test", "iPhone X")
        try TestHelper.createTestSimulators(app: app, simulators: [device])
        try TestHelper.bootSimulator(app: app, device: device.0)
        let createdDevice = try TestHelper.getDevices(app: app).first(where: { $0.name == device.0 })
        XCTAssertEqual(createdDevice?.state, "Booted")
        
        addTeardownBlock { [weak self] in
            try? TestHelper.shutdownSimulator(app: self!.app, device: device.0)
            try? TestHelper.deleteTestSimulator(app: self!.app, simulators: [device.0])
        }
    }
    
    func testCreateDefaultSimulators() throws {
        try TestHelper.deleteAllSimulators(app: app)
        try TestHelper.createDefaultSimulators(app: app)
        let devices = try TestHelper.getDevices(app: app)
        let defaultDevices = try TestHelper.getDefaultDeviceTypes(app: app)
        XCTAssertGreaterThan(devices.count, 0)
        XCTAssertEqual(devices.count, defaultDevices.count)
    }
    
    func testCreateTestSimulators() throws {
        let device = ("test", "iPhone X")
        try TestHelper.createTestSimulators(app: app, simulators: [device])
        let deviceCreated = try TestHelper.getDevices(app: app).contains { $0.name == device.0 }
        XCTAssertTrue(deviceCreated)
        
        addTeardownBlock { [weak self] in
            try? TestHelper.deleteTestSimulator(app: self!.app, simulators: ["test"])
        }
    }
    
    func testDeleteAllSimulators() throws {
        try TestHelper.deleteAllSimulators(app: app)
        let devices = try TestHelper.getDevices(app: app)
        XCTAssertEqual(devices.count, 0)
        
        addTeardownBlock { [weak self] in
            try? TestHelper.createDefaultSimulators(app: self!.app)
        }
    }
    
    func testDeleteTestSimulator() throws {
        let devices = [("test", "iPhone X"), ("test2", "iPhone X")]
        try TestHelper.createTestSimulators(app: app, simulators: devices)
        try TestHelper.deleteTestSimulator(app: app, simulators: ["test", "test2"])
        let devicesPresent = try TestHelper.getDevices(app: app).contains {
            $0.name == devices[0].0 || $0.name == devices[1].0
        }
        XCTAssertFalse(devicesPresent)
    }
    
    func testDeviceExists() throws {
        try TestHelper.createTestSimulators(app: app, simulators: [("test", "iPhone X")])
        let deviceExists = try TestHelper.deviceExists(app: app, named: "test")
        XCTAssertTrue(deviceExists)
        
        addTeardownBlock { [weak self] in
            try? TestHelper.deleteTestSimulator(app: self!.app, simulators: ["test"])
        }
    }
    
    func testFilterDeviceTypes() throws {
        let deviceTypes = try TestHelper.getDeviceTypes(app: app)
        let output = try TestHelper.filterDeviceTypes(deviceTypes: deviceTypes)
        XCTAssertGreaterThan(output.count, 0)
        XCTAssertGreaterThan(output[.iPhone]?.count ?? 0, 0)
    }
    
    func testGetAvailableRuntimes() throws {
        let output = try TestHelper.getAvailableRuntimes(app: app)
        XCTAssertGreaterThan(output.count, 0)
    }
    
    func testGetDefaultDeviceTypes() throws {
        let availableDeviceTypes = try TestHelper.getDeviceTypes(app: app)
        let defaultDeviceTypes = try TestHelper.getDefaultDeviceTypes(app: app)
        
        let filteredDefaultDeviceTypes = try TestHelper.filterDeviceTypes(deviceTypes: defaultDeviceTypes)
        let filteredAvailableDeviceTypes = try TestHelper.filterDeviceTypes(deviceTypes: availableDeviceTypes)
        XCTAssertEqual(filteredDefaultDeviceTypes[.appleWatch]?.count, TestHelper.appleWatchDevices)
        XCTAssertEqual(filteredDefaultDeviceTypes[.appleTV]?.count, filteredAvailableDeviceTypes[.appleTV]?.count)
        XCTAssertEqual(filteredDefaultDeviceTypes[.iPad]?.count, TestHelper.iPadDevices)
        XCTAssertEqual(filteredDefaultDeviceTypes[.iPhone]?.count, TestHelper.iPhoneDevices)
    }
    
    func testGetDevices() throws {
        let testDevices = [("test", "iPhone X")]
        try TestHelper.createTestSimulators(app: app, simulators: testDevices)
        let devices = try TestHelper.getDevices(app: app)
        let devicePresent = devices.contains { $0.name == testDevices[0].0 }
        XCTAssertTrue(devicePresent)
        XCTAssertGreaterThan(devices.count, 1)
        
        addTeardownBlock { [weak self] in
            try? TestHelper.deleteTestSimulator(app: self!.app, simulators: ["test"])
        }
    }
    
    func testGetDeviceTypes() throws {
        let output = try TestHelper.getDeviceTypes(app: app)
        XCTAssertGreaterThan(output.count, 0)
    }
    
    func testRemoveTestSimulators() throws {
        let testDevice = [("test", "iPhone X"), ("test2", "iPhone X")]
        try TestHelper.createTestSimulators(app: app, simulators: testDevice)
        let devices = try TestHelper.getDevices(app: app)
        try TestHelper.removeTestSimulators(app: app)
        let updatedDevices = try TestHelper.getDevices(app: app)
        XCTAssertGreaterThan(devices.count, updatedDevices.count)
    }
    
    func testShutdownSimulator() throws {
        let device = ("test", "iPhone X")
        try TestHelper.createTestSimulators(app: app, simulators: [device])
        try TestHelper.bootSimulator(app: app, device: device.0)
        try TestHelper.shutdownSimulator(app: app, device: device.0)
        let createdDevice = try TestHelper.getDevices(app: app).first(where: { $0.name == device.0 })
        XCTAssertEqual(createdDevice?.state, "Shutdown")
        
        addTeardownBlock { [weak self] in
            try? TestHelper.deleteTestSimulator(app: self!.app, simulators: [device.0])
        }
    }
    
    func testWaitUntilBooted() throws {
        
    }
}
