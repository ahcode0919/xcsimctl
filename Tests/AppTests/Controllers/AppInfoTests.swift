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
    var simulator: Simulator!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = Application(.testing)
        simulator = Simulator(device: .testAppInfo, type: .iPhone8)
        try configure(app)
        try TestHelper.createTestSimulators(app: app, simulators: [simulator])
        try TestHelper.bootSimulator(app: app, device: .testAppInfo)
    }
    
    override func tearDownWithError() throws {
        try TestHelper.deleteTestSimulators(app: app, simulators: [simulator])
        app.shutdown()

        try super.tearDownWithError()
    }

    func testAppInfo() throws {
        try app.test(.GET, "appinfo/\(simulator.device.name)/com.apple.mobilesafari", afterResponse: { res in
            XCTAssertFalse(res.body.string.isEmpty)
            XCTAssertEqual(res.status, .ok)
        })
    }
}
