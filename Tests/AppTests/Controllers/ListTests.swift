//
//  File.swift
//  
//
//  Created by Aaron Hinton on 4/11/21.
//

import Foundation
import XCTVapor
@testable import App

class ListTests: XCTestCase {
    func testList() throws {
        let devices = List.list()
        XCTAssertNotNil(devices.devicetypes)
        XCTAssertNotNil(devices.devices)
        XCTAssertNotNil(devices.pairs)
        XCTAssertNotNil(devices.runtimes)
    }
}
