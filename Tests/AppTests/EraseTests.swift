//
//  EraseTests.swift
//
//
//  Created by Aaron Hinton on 4/18/21.
//

import Foundation

@testable import App
import XCTVapor

final class EraseTests: XCTestCase {
    var app: Application!
    
    override func setUpWithError() throws {
        app = Application(.testing)
        try configure(app)
        let path = try URLHelper.escape(url: "create/test/iPhone X")
        let path2 = try URLHelper.escape(url: "create/test2/iPhone X")
        try app.test(.POST, path)
        try app.test(.POST, path2)
    }
    
    override func tearDownWithError() throws {
        try app.test(.POST, "delete/test")
        app.shutdown()
    }

    func testErase() throws {
        let path = try URLHelper.escape(url: "erase/test")
        try app.test(.POST, path, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "")
        })
    }
    
    func testEraseAll() throws {
        try app.test(.POST, "erase/all", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "")
        })
    }
    
    func testEraseDevices() throws {
        try app.test(.POST, "erase?devices=test", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "")
        })
        
        try app.test(.POST, "erase?devices=test,test2", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "")
        })
    }
    
    func testDeleteInvalidDevice() throws {
        try app.test(.POST, "erase?devices=foo", afterResponse: { res in
            XCTAssertEqual(res.status, .internalServerError)
           
            let error = try res.content.decode(ErrorResponse.self)
            XCTAssertContains(error.reason, "Invalid device: foo")
        })
        
        try app.test(.POST, "erase/foo", afterResponse: { res in
            XCTAssertEqual(res.status, .internalServerError)
           
            let error = try res.content.decode(ErrorResponse.self)
            XCTAssertContains(error.reason, "Invalid device: foo")
        })
    }
}
