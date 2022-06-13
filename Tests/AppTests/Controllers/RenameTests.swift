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
    var simulator: Simulator!
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        app = Application(.testing)
        simulator = Simulator(device: .test(), type: .iPhone8)

        try configure(app)
        try TestHelper.createTestSimulators(app: app, simulators: [simulator])
    }
    
    override func tearDownWithError() throws {        
        try TestHelper.removeTestSimulators(app: app)
        app.shutdown()
        
        try super.tearDownWithError()
    }

    func testRename() throws {
        let device: TestDevice = .testRenamed
        try app.test(.POST, "rename/\(simulator.device.name)/\(device.name)", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
        XCTAssertTrue(try TestHelper.deviceExists(app: app, named: device))
    }
}
