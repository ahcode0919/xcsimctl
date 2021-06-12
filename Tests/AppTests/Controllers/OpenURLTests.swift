//
//  OpenURLTests.swift
//  
//
//  Created by Aaron Hinton on 5/25/21.
//

import Foundation
import XCTVapor
@testable import App

final class OpenURLTests: XCTestCase {
    var app: Application!
    let simulator = ("testopenurl", "iPhone 8")
    
    override func setUpWithError() throws {
        app = Application(.testing)
        try configure(app)
        try TestHelper.createTestSimulators(app: app, simulators: [simulator])
        try TestHelper.bootSimulator(app: app, device: simulator.0)
        try TestHelper.waitUntilBooted(app: app, device: simulator.0)
    }
    
    override func tearDownWithError() throws {
        try TestHelper.shutdownSimulator(app: app, device: simulator.0)
        try TestHelper.deleteTestSimulator(app: self.app, simulators: [simulator.0])
        app.shutdown()
    }

    func testOpenUrl() throws {
        let url = try URLHelper.escape(url: "openurl/\(simulator.0)")
        
        try app.test(.POST, url, beforeRequest: { req in
            try req.content.encode(OpenURL(url: "https://www.google.com"))
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
}
