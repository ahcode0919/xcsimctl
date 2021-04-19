//
//  DeleteTests.swift
//
//
//  Created by Aaron Hinton on 4/18/21.
//

import Foundation

@testable import App
import XCTVapor

final class DeleteTests: XCTestCase {
    var app: Application!
    
    override func setUpWithError() throws {
        app = Application(.testing)
        try configure(app)
        let path = try URLHelper.escape(url: "create/test/iPhone X")
        try app.test(.POST, path)
    }
    
    override func tearDownWithError() throws {
        app.shutdown()
    }

    func testDelete() throws {
        let path = try URLHelper.escape(url: "delete?named=test")
        try app.test(.POST, path, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "")
        })
    }
    
    func testDeleteAll() throws {
        try app.test(.POST, "delete/all", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "")
        })
    }
    
    func testDeleteInvalidDevice() throws {
        try app.test(.POST, "delete?named=foo", afterResponse: { res in
            XCTAssertEqual(res.status, .internalServerError)
           
            let error = try res.content.decode(ErrorResponse.self)
            XCTAssertContains(error.reason, "Invalid device: foo")
        })
    }
    
    func testDeleteUnavailable() throws {
        try app.test(.POST, "delete/unavailable", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "")
        })
    }
}
