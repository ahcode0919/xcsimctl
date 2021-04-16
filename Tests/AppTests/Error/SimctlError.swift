//
//  SimctlError.swift
//  
//
//  Created by Aaron Hinton on 4/15/21.
//

import Foundation

@testable import App
import XCTVapor

final class SimctlTests: XCTestCase {
    func testSimctlCommandError() {
        var commandError = SimctlError.simctlCommandError(nil)
        XCTAssertEqual(commandError.status, .internalServerError)
        XCTAssertEqual(commandError.reason, "Unable execute simctl command")
        
        commandError = SimctlError.simctlCommandError("Test")
        XCTAssertEqual(commandError.status, .internalServerError)
        XCTAssertEqual(commandError.reason, "Unable execute simctl command:\nTest")
    }
    
    func testSimctlError() {
        let simctlError = SimctlError.simctlError
        XCTAssertEqual(simctlError.status, .internalServerError)
        XCTAssertEqual(simctlError.reason, "simctl command failed")
    }
    
    func testSimctlParseError() {
        var parseError = SimctlError.simctlParseError(nil)
        XCTAssertEqual(parseError.status, .internalServerError)
        XCTAssertEqual(parseError.reason, "Unable to parse simctl output")
        
        parseError = SimctlError.simctlParseError("Test")
        XCTAssertEqual(parseError.status, .internalServerError)
        XCTAssertEqual(parseError.reason, "Unable to parse simctl output:\nTest")
    }
}