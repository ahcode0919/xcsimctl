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
        XCTAssertEqual(commandError.reason, "Unable execute simctl command: Test")
    }
    
    func testSimctlError() {
        var simctlError = SimctlError.error()
        XCTAssertEqual(simctlError.status, .internalServerError)
        XCTAssertEqual(simctlError.reason, "simctl command failed")
        
        simctlError = SimctlError.error("error message")
        XCTAssertEqual(simctlError.status, .internalServerError)
        XCTAssertEqual(simctlError.reason, "simctl command failed: \"error message\"")
    }
    
    func testSimctlMissingRouteParameters() {
        var missingRouteParameters = SimctlError.missingRouteParameters()
        XCTAssertEqual(missingRouteParameters.status, .badRequest)
        XCTAssertEqual(missingRouteParameters.reason, "Missing one or more route parameters")
        
        missingRouteParameters = SimctlError.missingRouteParameters(["Test"])
        XCTAssertEqual(missingRouteParameters.status, .badRequest)
        XCTAssertEqual(missingRouteParameters.reason, "Missing the following route parameter: Test")
        
        missingRouteParameters = SimctlError.missingRouteParameters(["Test", "Test2"])
        XCTAssertEqual(missingRouteParameters.status, .badRequest)
        XCTAssertEqual(missingRouteParameters.reason, "Missing the following route parameters: Test, Test2")
    }
    
    func testSimctlParseError() {
        var parseError = SimctlError.parseError()
        XCTAssertEqual(parseError.status, .internalServerError)
        XCTAssertEqual(parseError.reason, "Unable to parse simctl output")
        
        parseError = SimctlError.parseError("Test")
        XCTAssertEqual(parseError.status, .internalServerError)
        XCTAssertEqual(parseError.reason, "Unable to parse simctl output: Test")
    }
}
