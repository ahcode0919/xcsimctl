//
//  RenameTests.swift
//  
//
//  Created by Aaron Hinton on 5/20/21.
//

import Foundation
import XCTVapor
@testable import App

final class RenameTests: XCTestCase {
    var app: Application!
    
    override func setUpWithError() throws {
        app = Application(.testing)
        try configure(app)
        try TestHelper.createTestSimulators(app: app, simulators: [("test", "iPhone 8")])
    }
    
    override func tearDownWithError() throws {
        let devices = ["renamed-test", "test"]
        
        for device in devices {
            if (try? TestHelper.deviceExists(app: self.app, named: device)) ?? false {
                try? TestHelper.deleteTestSimulator(app: self.app, simulators: [device])
            }
        }
        app.shutdown()
    }

    func testRename() throws {
        try app.test(.POST, "rename/test/renamed-test", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
        XCTAssertTrue(try TestHelper.deviceExists(app: app, named: "renamed-test"))
    }
}
