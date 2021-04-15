//
//  AppTests.swift
//
//
//  Created by Aaron Hinton on 4/14/21.
//

import Foundation

@testable import App
import XCTVapor

final class AppTests: XCTestCase {
    var app: Application!
    
    override func setUpWithError() throws {
        app = Application(.testing)
        try configure(app)
    }
    
    override func tearDownWithError() throws {
        app.shutdown()
    }
    
    func testApp() throws {
        try app.test(.GET, "/", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "XCSimctl Server")
        })
    }
    
    func testPing() throws {
        try app.test(.GET, "ping", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
}
