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
    var test: Simulator!
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        app = Application(.testing)
        test = Simulator(device: .test(), type: .iPhone8)

        try configure(app)
        try TestHelper.createTestSimulators(app: app, simulators: [test])
    }
    
    override func tearDownWithError() throws {
        try app.test(.POST, "delete?named=\(test.device.name)")
        app.shutdown()
        
        try super.tearDownWithError()
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
