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
        try super.setUpWithError()

        app = Application(.testing)
        try configure(app)
        try TestHelper.removeTestSimulators(app: app)
    }
    
    override func tearDownWithError() throws {
        try TestHelper.removeTestSimulators(app: app)
        app.shutdown()
    
        try super.tearDownWithError()
    }
    
    func testBootSimulator() throws {
        let simulator = Simulator(device: .testBooted, type: .iPhone8)

        try TestHelper.createTestSimulators(app: app, simulators: [simulator])
        try TestHelper.bootSimulator(app: app, device: simulator.device)
        try TestHelper.waitUntilBooted(app: app, device: simulator.device)

        let createdDevice = try TestHelper.getDevices(app: app).first(where: { $0.name == simulator.device.name })
        XCTAssertEqual(createdDevice?.state, "Booted")
        
        addTeardownBlock { [self] in
            try? TestHelper.shutdownSimulator(app: self.app, simulator: simulator)
            try? TestHelper.deleteTestSimulators(app: self.app, simulators: [simulator])
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
        let simulator = Simulator(device: .testCreate, type: .iPhone8)

        try TestHelper.createTestSimulators(app: app, simulators: [simulator])
        let deviceCreated = try TestHelper.getDevices(app: app).contains { $0.name == simulator.device.name }
        XCTAssertTrue(deviceCreated)
        
        addTeardownBlock { [self] in
            try? TestHelper.deleteTestSimulators(app: self.app, simulators: [simulator])
        }
    }
    
    func testDeleteAllSimulators() throws {
        try TestHelper.deleteAllSimulators(app: app)
        let devices = try TestHelper.getDevices(app: app)
        XCTAssertEqual(devices.count, 0)
        
        addTeardownBlock { [self] in
            try? TestHelper.createDefaultSimulators(app: self.app)
        }
    }
    
    func testDeleteTestSimulator() throws {
        let simulators = [
            Simulator(device: .test(), type: .iPhone8),
            Simulator(device: .test("2"), type: .iPhone8)
        ]

        try TestHelper.createTestSimulators(app: app, simulators: simulators)
        try TestHelper.deleteTestSimulators(app: app, simulators: simulators)
        let devicesPresent = try TestHelper.getDevices(app: app).contains {
            $0.name == simulators[0].device.name || $0.name == simulators[1].device.name
        }
        XCTAssertFalse(devicesPresent)
    }
    
    func testDeviceExists() throws {
        let simulator = Simulator(device: .test(), type: .iPhone8)
        try TestHelper.createTestSimulators(app: app, simulators: [simulator])
        let deviceExists = try TestHelper.deviceExists(app: app, named: simulator.device)
        XCTAssertTrue(deviceExists)
        
        addTeardownBlock { [self] in
            try? TestHelper.deleteTestSimulators(app: self.app, simulators: [simulator])
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
        let simulator = Simulator(device: .test(), type: .iPhone8)
        try TestHelper.createTestSimulators(app: app, simulators: [simulator])

        let devices = try TestHelper.getDevices(app: app)
        let devicePresent = devices.contains { $0.name == simulator.device.name }
        XCTAssertTrue(devicePresent)
        XCTAssertGreaterThan(devices.count, 1)
        
        addTeardownBlock { [self] in
            try? TestHelper.deleteTestSimulators(app: self.app, simulators: [simulator])
        }
    }
    
    func testGetDeviceTypes() throws {
        let output = try TestHelper.getDeviceTypes(app: app)
        XCTAssertGreaterThan(output.count, 0)
    }
    
    func testRemoveTestSimulators() throws {
        let simulators = [
            Simulator(device: .test(), type: .iPhone8),
                      Simulator(device: .test("2"), type: .iPhone8)
        ]

        try TestHelper.createTestSimulators(app: app, simulators: simulators)
        let devices = try TestHelper.getDevices(app: app)
        try TestHelper.removeTestSimulators(app: app)
        let updatedDevices = try TestHelper.getDevices(app: app)
        XCTAssertGreaterThan(devices.count, updatedDevices.count)
    }
    
    func testShutdownSimulator() throws {
        let simulator = Simulator(device: .test(), type: .iPhone8)

        try TestHelper.createTestSimulators(app: app, simulators: [simulator])
        try TestHelper.bootSimulator(app: app, device: simulator.device)
        try TestHelper.shutdownSimulator(app: app, simulator: simulator)

        let createdDevice = try TestHelper.getDevices(app: app).first(where: { $0.name == simulator.device.name })
        XCTAssertEqual(createdDevice?.state, "Shutdown")
        
        addTeardownBlock { [self] in
            try? TestHelper.deleteTestSimulators(app: self.app, simulators: [simulator])
        }
    }
}
