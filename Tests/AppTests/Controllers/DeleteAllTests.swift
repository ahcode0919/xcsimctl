//
//  DeleteAllTests.swift
//
//
//  Created by Aaron Hinton on 4/18/21.
//

import Foundation

@testable import App
import XCTVapor

final class DeleteAllTests: XCTestCase {
    var app: Application!
    
    override func setUpWithError() throws {
        app = Application(.testing)
        try configure(app)
    }
    
    override func tearDownWithError() throws {
        app.shutdown()
    }

    func testDeleteAll() throws {
        try app.test(.POST, "delete/all", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "")
        })
        
        addTeardownBlock {
            try? TestHelper.createDefaultSimulators(app: self.app)
        }
    }
}
