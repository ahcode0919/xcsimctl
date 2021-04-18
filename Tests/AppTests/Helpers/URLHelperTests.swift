//
//  URLHelperTests.swift
//
//
//  Created by Aaron Hinton on 4/15/21.
//

import Foundation

@testable import App
import XCTVapor

final class URLHelperTests: XCTestCase {
    func testSimctlCommandError() throws {
        let output = try URLHelper.escape(url: "/test n?foo=bar")
        XCTAssertEqual(output, "/test%20n?foo=bar")
    }
}
