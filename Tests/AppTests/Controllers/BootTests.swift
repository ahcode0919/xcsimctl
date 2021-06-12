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
    
    override func setUpWithError() throws {
        app = Application(.testing)
        try configure(app)
        try TestHelper.createTestSimulators(app: app, simulators: [("test", "iPhone 8")])
    }
    
    override func tearDownWithError() throws {
        try TestHelper.shutdownSimulator(app: app, device: "test")
        try TestHelper.deleteTestSimulator(app: app, simulators: ["test"])
        app.shutdown()
    }

    func testBoot() throws {
        try app.test(.POST, "boot/test", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
    
    func testBootError() throws {
        try app.test(.POST, "boot/test", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
        try app.test(.POST, "boot/test", afterResponse: { res in
            XCTAssertEqual(res.status, .internalServerError)
            XCTAssertFalse(res.body.string.isEmpty)
        })
    }
}
