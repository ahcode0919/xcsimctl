//
//  File.swift
//  
//
//  Created by Aaron Hinton on 6/10/22.
//

import Foundation

extension String {
    
    /// Removes Metal and XCRun errors from Big Sur bug when running in debug mode in XCode
    /// - Returns: String without invalid system errors
    public func sanitize() -> String {
        if #available(macOS 12, *) {
            return self
        } else {
            let regex = "^[0-9\\-]+\\s[0-9:.\\-]+\\s(simctl|xcrun)"
            return self.split(separator: "\n")
                .filter({ $0.range(of: regex, options: .regularExpression) == nil })
                .joined(separator: "\n")
        }
    }
}
