//
//  StringHelpers.swift
//  
//
//  Created by Aaron Hinton on 4/18/21.
//

import Foundation

extension String {
    
    /// Remove whitespace from the beginnning and end of a string
    /// - Returns: sanitized string
    func chomp() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
