//
//  OpenURLTests.swift
//  
//
//  Created by Aaron Hinton on 5/25/21.
//

import Foundation
import XCTVapor
@testable import App
import XCTest

final class OpenURLTests: XCTestCase {
    var app: Application!
    var simulator: Simulator!
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        app = Application(.testing)
        simulator = Simulator(device: .testOpenURL, type: .iPhone8)

        try configure(app)
        try TestHelper.createTestSimulators(app: app, simulators: [simulator])
        try TestHelper.bootSimulator(app: app, device: simulator.device)
        try TestHelper.waitUntilBooted(app: app, device: simulator.device)
    }
    
    override func tearDownWithError() throws {
        try TestHelper.shutdownSimulator(app: app, simulator: simulator)
        try TestHelper.removeTestSimulators(app: app)
        app.shutdown()

        try super.tearDownWithError()
    }

    func testOpenUrl() throws {
        let url = try URLHelper.escape(url: "openurl/\(simulator.device.name)")
        let options = XCTExpectedFailure.Options()
        options.isStrict = false

        let _ = try XCTExpectFailure("Slow boot error with simulator", options: options) {
            try app.test(.POST, url, beforeRequest: { req in
                try req.content.encode(OpenURLRequest(url: "https://www.google.com"))
            }, afterResponse: { res in
                XCTAssertEqual(res.status, .ok)
            })
        }
    }
}
