//
//  File.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation

@testable import App
import XCTVapor

final class AppInfoTests: XCTestCase {
    var app: Application!
    
    override func setUpWithError() throws {
        app = Application(.testing)
        try configure(app)
        try TestHelper.createTestSimulators(app: app, simulators: [("testappinfo", "iPhone 8")])
        try TestHelper.bootSimulator(app: app, device: "testappinfo")
    }
    
    override func tearDownWithError() throws {
        try TestHelper.deleteTestSimulator(app: app, simulators: ["testappinfo"])
        app.shutdown()
    }

    func testAppInfo() throws {
        try app.test(.GET, "appinfo/testappinfo/com.apple.mobilesafari", afterResponse: { res in
            XCTAssertFalse(res.body.string.isEmpty)
            XCTAssertEqual(res.status, .ok)
        })
    }
}
