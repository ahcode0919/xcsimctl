//
//  ShutdownTests.swift
//  
//
//  Created by Aaron Hinton on 5/5/21.
//

import Foundation
import XCTVapor
@testable import App

final class ShutdownTests: XCTestCase {
    var app: Application!
    var simulator: Simulator!
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        app = Application(.testing)
        simulator = Simulator(device: .test(), type: .iPhone8)
        
        try configure(app)
        try TestHelper.createTestSimulators(app: app, simulators: [simulator])
        try app.test(.POST, "boot/\(simulator.device.name)")
    }
    
    override func tearDownWithError() throws {
        try TestHelper.removeTestSimulators(app: app)
        app.shutdown()
        
        try super.tearDownWithError()
    }

    func testShutdown() throws {
        try app.test(.POST, "shutdown/\(simulator.device.name)", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
    
    func testShutdownAll() throws {
        try app.test(.POST, "shutdown/all", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
    
    func testShutdownError() throws {
        try app.test(.POST, "shutdown/\(simulator.device.name)", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
        try app.test(.POST, "shutdown/\(simulator.device.name)", afterResponse: { res in
            XCTAssertEqual(res.status, .internalServerError)
            
            let error = try res.content.decode(ErrorResponse.self)
            XCTAssertContains(error.reason, "Unable to shutdown device")
        })
    }
}
