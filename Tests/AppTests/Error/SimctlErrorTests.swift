//
//  SimctlErrorTests.swift
//  
//
//  Created by Aaron Hinton on 4/15/21.
//

import Foundation

@testable import App
import XCTVapor

final class SimctlErrorTests: XCTestCase {
    func testSimctlCommandError() {
        var commandError = SimctlError.commandError()
        XCTAssertEqual(commandError.status, .internalServerError)
        XCTAssertEqual(commandError.reason, "Unable execute simctl command")
        
        commandError = SimctlError.commandError("Test")
        XCTAssertEqual(commandError.status, .internalServerError)
        XCTAssertEqual(commandError.reason, "Unable execute simctl command:\nTest")
    }
    
    func testSimctlError() {
        let simctlError = SimctlError.error()
        XCTAssertEqual(simctlError.status, .internalServerError)
        XCTAssertEqual(simctlError.reason, "simctl command failed")
    }
    
    func testSimctlParseError() {
        var parseError = SimctlError.parseError()
        XCTAssertEqual(parseError.status, .internalServerError)
        XCTAssertEqual(parseError.reason, "Unable to parse simctl output")
        
        parseError = SimctlError.parseError("Test")
        XCTAssertEqual(parseError.status, .internalServerError)
        XCTAssertEqual(parseError.reason, "Unable to parse simctl output:\nTest")
    }
}
