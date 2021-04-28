//
//  RuntimeOS.swift
//  
//
//  Created by Aaron Hinton on 4/24/21.
//

import Foundation

enum RuntimeOS: String, CaseIterable {
    case ios = "iOS"
    case tvos = "tvOS"
    case watchos = "watchOS"
    
    static func getRuntimeOS(runtime: String) -> RuntimeOS? {
        for appRuntime in RuntimeOS.allCases {
            if runtime.hasPrefix(appRuntime.rawValue) {
                return appRuntime
            }
        }
        return nil
    }
}
