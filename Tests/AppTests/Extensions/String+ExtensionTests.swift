//
//  String+ExtensionTests.swift
//  
//
//  Created by Aaron Hinton on 4/18/21.
//

import Foundation
import XCTest

@testable import App

final class StringHelperTest: XCTestCase {
    func testChomp() {
        let testString = " \n\t\r\ntest \n\t\r\n"
        XCTAssertEqual(testString.chomp(), "test")
    }
}
