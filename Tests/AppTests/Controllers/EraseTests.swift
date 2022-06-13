//
//  EraseTests.swift
//
//
//  Created by Aaron Hinton on 4/18/21.
//

import Foundation

@testable import App
import XCTVapor

final class EraseTests: XCTestCase {
    var app: Application!
    var test: Simulator!
    var test2: Simulator!
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        app = Application(.testing)
        test = Simulator(device: .test(), type: .iPhone8)
        test2 = Simulator(device: .test("2"), type: .iPhone8)
        
        try configure(app)
        try TestHelper.createTestSimulators(app: app, simulators: [test, test2])
    }
    
    override func tearDownWithError() throws {
        try TestHelper.removeTestSimulators(app: app)
        app.shutdown()
        
        try super.tearDownWithError()
    }

    func testErase() throws {
        let path = try URLHelper.escape(url: "erase/\(test.device.name)")

        try app.test(.POST, path, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "")
        })
    }
    
    func testEraseAll() throws {
        try app.test(.POST, "erase/all", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "")
        })
    }
    
    func testEraseDevices() throws {
        try app.test(.POST, "erase?devices=\(test.device.name)", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "")
        })
        
        try app.test(.POST, "erase?devices=\(test.device.name),\(test.device.name)", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "")
        })
    }
    
    func testDeleteInvalidDevice() throws {
        try app.test(.POST, "erase?devices=foo", afterResponse: { res in
            XCTAssertEqual(res.status, .internalServerError)
           
            let error = try res.content.decode(ErrorResponse.self)
            XCTAssertContains(error.reason, "Invalid device: foo")
        })
        
        try app.test(.POST, "erase/foo", afterResponse: { res in
            XCTAssertEqual(res.status, .internalServerError)
           
            let error = try res.content.decode(ErrorResponse.self)
            XCTAssertContains(error.reason, "Invalid device: foo")
        })
    }
}
