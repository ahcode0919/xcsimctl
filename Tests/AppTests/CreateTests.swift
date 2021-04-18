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
    
    override func setUpWithError() throws {
        app = Application(.testing)
        try configure(app)
    }
    
    override func tearDownWithError() throws {
        app.shutdown()
    }

    func testCreate() throws {
        let path = try URLHelper.escape(url: "create/test/iPhone X")
        try app.test(.POST, path, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertNoThrow(try res.content.decode(CreateResponse.self))
        })
    }
    
    func testCreateWithRuntime() throws {
        let path = try URLHelper.escape(url: "create/test/iPhone X?runtime=iOS13.6")
        try app.test(.POST, path, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertNoThrow(try res.content.decode(CreateResponse.self))
        })
    }
    
    func testIncompatibleDeviceTypeAndRuntime() throws {
         let path = try URLHelper.escape(url: "create/test/iPhone X?runtime=tvOS13.4")
        try app.test(.POST, path, afterResponse: { res in
            XCTAssertEqual(res.status, .internalServerError)
            XCTAssertContains(res.body.string, CreateError.incompatibleDevice.message)
        })
    }
    
    func testInvalidDeviceType() throws {
        try app.test(.POST, "create/test/foo", afterResponse: { res in
            XCTAssertEqual(res.status, .internalServerError)
            XCTAssertContains(res.body.string, CreateError.invalidDeviceType.message)
        })
    }
    
    func testInvalidRuntime() throws {
        let path = try URLHelper.escape(url: "/create/test/iPhone X?runtime=foo")
        try app.test(.POST, path, afterResponse: { res in
            XCTAssertEqual(res.status, .internalServerError)
            XCTAssertContains(res.body.string, CreateError.invalidRuntime.message)
        })
    }
    
    func testMissingParameters() throws {
        try app.test(.POST, "create", afterResponse: { res in
            XCTAssertEqual(res.status, .notFound)
        })
    }
}
