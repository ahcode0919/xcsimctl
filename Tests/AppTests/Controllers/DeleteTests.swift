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
    var test: Simulator!
    var test2: Simulator!
    var test3: Simulator!
    var test4: Simulator!
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        app = Application(.testing)
        try configure(app)

        test = Simulator(device: .test(), type: .iPhone8)
        test2 = Simulator(device: .test("2"), type: .iPhone8)
        test3 = Simulator(device: .test("3"), type: .iPhone8)
        test4 = Simulator(device: .test("4"), type: .iPhone8)
        
        let simulators: [Simulator] = [
            test,
            test2,
            test3,
            test4
        ]
        try? TestHelper.createTestSimulators(app: app, simulators: simulators)
        
        try super.tearDownWithError()
    }
    
    override func tearDownWithError() throws {
        app.shutdown()
    }

    func testDelete() throws {
        let path = try URLHelper.escape(url: "delete/\(test.device.name)")
        try app.test(.POST, path, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
    
    func testDeleteDevices() throws {
        var path = try URLHelper.escape(url: "delete?devices=\(test2.device.name)")
        try app.test(.POST, path, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
        
        path = try URLHelper.escape(url: "delete?devices=\(test3.device.name),\(test4.device.name)")
        try app.test(.POST, path, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
    
    func testDeleteInvalidDevice() throws {
        try app.test(.POST, "delete?devices=foo", afterResponse: { res in
            XCTAssertEqual(res.status, .internalServerError)
           
            let error = try res.content.decode(ErrorResponse.self)
            XCTAssertContains(error.reason, "Invalid device: foo")
        })
    }
    
    func testDeleteUnavailable() throws {
        try app.test(.POST, "delete/unavailable", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
}
