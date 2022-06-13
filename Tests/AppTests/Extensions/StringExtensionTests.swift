//
//  StringExtensionTests.swift
//  
//
//  Created by Aaron Hinton on 6/12/22.
//

import XCTest

class StringExtensionTests: XCTestCase {
    
    private struct Test: Codable {
        let test: String
    }

    func testSanitize() throws {
        let empty = ""
        let errorOnly = """
        2022-01-01 23:43:40.457758-0700 xcrun[39541:1441754] Unknown binary with magic 0x622f2123 at /Applications/Xcode.app/Contents/Developer/usr/bin/simctl\n2022-01-01 23:43:40.519801-0700 simctl[39541:1441767] MTLIOAccelDevice bad MetalPluginClassName property (null)\n2022-01-01 23:43:40.523982-0700 simctl[39541:1441767] +[MTLIOAccelDevice registerDevices]: Zero Metal services found\n
        """
        let errorAndJSON = """
        2022-01-01 23:43:40.457758-0700 xcrun[39541:1441754] Unknown binary with magic 0x622f2123 at /Applications/Xcode.app/Contents/Developer/usr/bin/simctl\n2022-01-01 23:43:40.519801-0700 simctl[39541:1441767] MTLIOAccelDevice bad MetalPluginClassName property (null)\n2022-01-01 23:43:40.523982-0700 simctl[39541:1441767] +[MTLIOAccelDevice registerDevices]: Zero Metal services found\n{\"test\":\"value\"}
        """
        let errorAndPlaintext = """
        2022-01-01 23:43:40.457758-0700 xcrun[39541:1441754] Unknown binary with magic 0x622f2123 at /Applications/Xcode.app/Contents/Developer/usr/bin/simctl\n2022-01-01 23:43:40.519801-0700 simctl[39541:1441767] MTLIOAccelDevice bad MetalPluginClassName property (null)\n2022-01-01 23:43:40.523982-0700 simctl[39541:1441767] +[MTLIOAccelDevice registerDevices]: Zero Metal services found\nSome Error Happened:\nSome Error
        """
        let noErrorAndJSON = "{\"test\":\"value\"}"

        XCTAssertEqual(empty.sanitize(), "")
        XCTAssertEqual(errorOnly.sanitize(), "")
        XCTAssertEqual(errorAndJSON.sanitize(), noErrorAndJSON)
        XCTAssertEqual(errorAndPlaintext.sanitize(), "Some Error Happened:\nSome Error")
        XCTAssertEqual(noErrorAndJSON.sanitize(), noErrorAndJSON)
        
        var data = try XCTUnwrap(errorAndJSON.sanitize().data(using: .utf8))
        var json = try JSONDecoder().decode(Test.self, from: data)
        XCTAssertEqual(json.test, "value")
        
        data = try XCTUnwrap(noErrorAndJSON.sanitize().data(using: .utf8))
        json = try JSONDecoder().decode(Test.self, from: data)
        XCTAssertEqual(json.test, "value")
    }
}
