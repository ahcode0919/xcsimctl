//
//  CloneTests.swift
//
//  Created by Aaron Hinton on 5/4/21.
//

import Foundation

@testable import App
import XCTVapor

final class CloneTests: XCTestCase {
    var app: Application!
    
    override func setUpWithError() throws {
        app = Application(.testing)
        try configure(app)
        try TestHelper.createTestSimulators(app: app, simulators: [("test", "iPhone 8")])
    }
    
    override func tearDownWithError() throws {
        try TestHelper.deleteTestSimulator(app: app, simulators: ["test"])
        app.shutdown()
    }

    func testClone() throws {
        try app.test(.POST, "clone/test/test2", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            
            let response = try res.content.decode(CloneResponse.self)
            XCTAssertNotNil(UUID(uuidString: response.uuid.uuidString))
        })
        
        addTeardownBlock {
            try? TestHelper.deleteTestSimulator(app: self.app, simulators: ["test2"])
        }
    }
}
