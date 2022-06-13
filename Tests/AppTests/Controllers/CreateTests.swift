//
//  CreateTests.swift
//  
//
//  Created by Aaron Hinton on 4/15/21.
//

import Foundation

@testable import App
import XCTVapor

final class CreateTests: XCTestCase {
    var app: Application!
    var runtimes: [RuntimeOS: String]!
    var simulator: Simulator!
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        app = Application(.testing)
        simulator = Simulator(device: .test(), type: .iPhone8)
        try configure(app)
        runtimes = try TestHelper.getAvailableRuntimes(app: app)
    }
    
    override func tearDownWithError() throws {
        try TestHelper.removeTestSimulators(app: app)
        app.shutdown()

        try super.tearDownWithError()
    }
    
    func testCreate() throws {
        let path = try URLHelper.escape(url: "create/\(simulator.device.name)/\(simulator.type.name)")

        try app.test(.POST, path, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertNoThrow(try res.content.decode(CreateResponse.self))
        })
    }
    
    func testCreateWithRuntime() throws {
        let runtime = try XCTUnwrap(runtimes[.ios])
        let url = "create/\(simulator.device.name)/\(simulator.type.name)?runtime=\(runtime)"
        let path = try URLHelper.escape(url: url)

        try app.test(.POST, path, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertNoThrow(try res.content.decode(CreateResponse.self))
        })
    }
    
    func testIncompatibleDeviceTypeAndRuntime() throws {
        let runtime = try XCTUnwrap(runtimes[.tvos])
        let url = "create/\(simulator.device.name)/\(simulator.type.name)?runtime=\(runtime)"
        let path = try URLHelper.escape(url: url)

        try app.test(.POST, path, afterResponse: { res in
            XCTAssertEqual(res.status, .internalServerError)

            let errorResponse = try res.content.decode(ErrorResponse.self)
            XCTAssertContains(errorResponse.reason, CreateError.incompatibleDevice.message)
        })
    }
    
    func testInvalidDeviceType() throws {
        try app.test(.POST, "create/\(simulator.device.name)/foo", afterResponse: { res in
            XCTAssertEqual(res.status, .internalServerError)

            let errorResponse = try res.content.decode(ErrorResponse.self)
            XCTAssertContains(errorResponse.reason, CreateError.invalidDeviceType.message)
        })
    }
    
    func testInvalidRuntime() throws {
        let path = try URLHelper.escape(url: "/create/\(simulator.device.name)/\(simulator.type.name)?runtime=foo")
        try app.test(.POST, path, afterResponse: { res in
            XCTAssertEqual(res.status, .internalServerError)

            let errorResponse = try res.content.decode(ErrorResponse.self)
            XCTAssertContains(errorResponse.reason, CreateError.invalidRuntime.message)
        })
    }
    
    func testMissingParameters() throws {
        try app.test(.POST, "create", afterResponse: { res in
            XCTAssertEqual(res.status, .notFound)
        })
    }
}
