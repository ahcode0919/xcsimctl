//
//  File.swift
//  
//
//  Created by Aaron Hinton on 4/15/21.
//

import Vapor

enum SimctlError {
    case simctlCommandError(String? = nil)
    case simctlError
    case simctlParseError(String? = nil)
}

extension SimctlError: AbortError {
    var reason: String {
        switch self {
        case .simctlCommandError(let command):
            let reason = "Unable execute simctl command"
            guard let command = command else {
                return reason
            }
            return "\(reason):\n\(command)"
        case .simctlError:
            return "simctl command failed"
        case .simctlParseError(let error):
            let reason = "Unable to parse simctl output"
            guard let error = error else {
                return reason
            }
            return "\(reason):\n\(error)"
        }
    }

    var status: HTTPStatus {
        switch self {
        case .simctlCommandError:
            return .internalServerError
        case .simctlError:
            return .internalServerError
        case .simctlParseError:
            return .internalServerError
        }
    }
}
