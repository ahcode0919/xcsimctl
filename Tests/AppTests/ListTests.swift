//
//  File.swift
//  
//
//  Created by Aaron Hinton on 4/14/21.
//

import Foundation

@testable import App
import XCTVapor

final class ListTests: XCTestCase {
    var app: Application!
    
    override func setUpWithError() throws {
        app = Application(.testing)
        try configure(app)
        let path = try URLHelper.escape(url: "create/test/iPhone X")
        try app.test(.POST, path)
    }
    
    override func tearDownWithError() throws {
        try app.test(.POST, "delete?named=test")
        app.shutdown()
    }
    
    func testList() throws {
        try app.test(.GET, "list", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertNotNil(try? res.content.decode(DeviceList.self))
        })
    }
    
    func testListDevices() throws {
        try app.test(.GET, "list/devices", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertNoThrow(try res.content.decode([String: [Device]].self))
        })
    }

    func testListDeviceTypes() throws {
        try app.test(.GET, "list/devicetypes", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertNoThrow(try res.content.decode([DeviceType].self))
        })
    }

    func testListPairs() throws {
        try app.test(.GET, "list/pairs", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertNoThrow(try res.content.decode([String: Pair].self))
        })
    }

    func testListRuntimes() throws {
        try app.test(.GET, "list/runtimes", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertNoThrow(try res.content.decode([Runtime].self))
        })
    }
}
