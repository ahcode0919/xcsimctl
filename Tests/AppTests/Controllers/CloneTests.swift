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
    var simulator: Simulator!
    var simulator2: Simulator!
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        app = Application(.testing)
        simulator = Simulator(device: .test(), type: .iPhone8)
        simulator2 = Simulator(device: .test("2"), type: .iPhone8)
        try configure(app)
        try TestHelper.createTestSimulators(app: app, simulators: [simulator])
    }
    
    override func tearDownWithError() throws {
        try TestHelper.deleteTestSimulators(app: app, simulators: [simulator])
        try TestHelper.deleteTestSimulators(app: app, simulators: [simulator2])
        app.shutdown()

        try super.tearDownWithError()
    }

    func testClone() throws {
        try app.test(.POST, "clone/\(simulator.device.name)/\(simulator2.device.name)", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            
            let response = try res.content.decode(CloneResponse.self)
            XCTAssertNotNil(UUID(uuidString: response.uuid.uuidString))
        })
    }
}
