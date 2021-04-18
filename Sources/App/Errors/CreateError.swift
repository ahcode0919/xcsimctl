//
//  CreateError.swift
//  
//
//  Created by Aaron Hinton on 4/15/21.
//

import Foundation
import Vapor

enum CreateError: CaseIterable {    
    case createError
    case incompatibleDevice
    case invalidDeviceType
    case invalidRuntime
    
    static func findError(_ message: String) -> CreateError {
        for error in Self.allCases {
            if message.contains(error.message) {
                return error
            }
        }
        return .createError
    }
}

extension CreateError {
    var message: String {
        switch self {
        case .createError:
            return "Create command failed"
        case .incompatibleDevice:
            return "Incompatible device"
        case .invalidDeviceType:
            return "Invalid device type"
        case .invalidRuntime:
            return "Invalid runtime"
        }
    }
}
