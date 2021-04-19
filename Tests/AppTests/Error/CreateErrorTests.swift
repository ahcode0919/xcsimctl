//
//  CreateErrorTests.swift
//  
//
//  Created by Aaron Hinton on 4/16/21.
//

import Foundation

@testable import App
import XCTVapor

final class CreateErrorTests: XCTestCase {
    func testCreateErrorMessage() throws {
        let createErrors = CreateError.allCases
        let messages: [CreateError: String] = [
            .createError : "Create command failed",
            .incompatibleDevice: "Incompatible device",
            .invalidDeviceType: "Invalid device type",
            .invalidRuntime: "Invalid runtime"
        ]
        
        XCTAssertEqual(createErrors.count, messages.count)
        XCTAssertTrue(createErrors.allSatisfy { $0.message == messages[$0] })
    }
 
    func testFindError() throws {
        let defaultError = CreateError.findError("Foo")
        let createError = CreateError.findError(CreateError.invalidDeviceType.message)
        XCTAssertEqual(defaultError, .createError)
        XCTAssertEqual(createError, .invalidDeviceType)
    }
}
