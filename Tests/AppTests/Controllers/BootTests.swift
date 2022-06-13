//
//  BootTests.swift
//  
//
//  Created by Aaron Hinton on 5/4/21.
//

import Foundation

@testable import App
import XCTVapor

final class BootTests: XCTestCase {
    var app: Application!
    var simulator: Simulator!
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        app = Application(.testing)
        simulator = Simulator(device: .test(), type: .iPhone8)
        try configure(app)
        try TestHelper.createTestSimulators(app: app, simulators: [simulator])
    }
    
    override func tearDownWithError() throws {
        try TestHelper.shutdownSimulator(app: app, simulator: simulator)
        try TestHelper.deleteTestSimulators(app: app, simulators: [simulator])
        app.shutdown()
        
        try super.tearDownWithError()
    }

    func testBoot() throws {
        try app.test(.POST, "boot/\(simulator.device.name)", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
    
    func testBootError() throws {
        try app.test(.POST, "boot/\(simulator.device.name)", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
        try app.test(.POST, "boot/\(simulator.device.name)", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)

            let bootResponse = try res.content.decode(SimctlResponse.self)
            let output = try XCTUnwrap(bootResponse.simctlOutput)
            XCTAssertTrue(output.contains("Booted"))
        })
    }
}
