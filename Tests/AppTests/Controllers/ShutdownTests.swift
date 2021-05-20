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
    
    override func setUpWithError() throws {
        app = Application(.testing)
        try configure(app)
        try TestHelper.createTestSimulators(app: app, simulators: [("test", "iPhone 8")])
        try app.test(.POST, "boot/test")
    }
    
    override func tearDownWithError() throws {
        try TestHelper.deleteTestSimulator(app: app, simulators: ["test"])
        app.shutdown()
    }

    func testShutdown() throws {
        try app.test(.POST, "shutdown/test", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
    
    func testShutdownAll() throws {
        try app.test(.POST, "shutdown/all", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
    
    func testShutdownError() throws {
        try app.test(.POST, "shutdown/test", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
        try app.test(.POST, "shutdown/test", afterResponse: { res in
            XCTAssertEqual(res.status, .internalServerError)
            XCTAssertFalse(res.body.string.isEmpty)
        })
    }
}
