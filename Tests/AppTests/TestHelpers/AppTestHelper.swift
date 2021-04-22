//
//  AppTestHelper.swift
//  
//
//  Created by Aaron Hinton on 4/20/21.
//

import Foundation
import XCTVapor
@testable import App

class AppTestHelper {
    static func getAvailableRuntimes(app: Application) throws -> [AppRuntime: String] {
        let group = DispatchGroup()
        var runtimes: [AppRuntime: String] = [:]
        group.enter()
        
        try app.test(.GET, "list/runtimes", afterResponse: { res in
            if let runtimesResponse = try? res.content.decode([Runtime].self) {
                for runtime in runtimesResponse {
                    if let appRuntime = AppRuntime.getRuntime(runtime: runtime.name) {
                        runtimes[appRuntime] = runtime.name.replacingOccurrences(of: " ", with: "")
                    }
                }
                group.leave()
            }
        })
        group.wait()
        return runtimes
    }
}

enum AppRuntime: String, CaseIterable {
    case ios = "iOS"
    case tvos = "tvOS"
    case watchos = "watchOS"
    
    static func getRuntime(runtime: String) -> AppRuntime? {
        for appRuntime in AppRuntime.allCases {
            if runtime.hasPrefix(appRuntime.rawValue) {
                return appRuntime
            }
        }
        return nil
    }
}
