//
//  SimctlError.swift
//  
//
//  Created by Aaron Hinton on 4/15/21.
//

import Vapor

enum SimctlError {
    case commandError(String? = nil)
    case error(String? = nil)
    case missingRouteParameters([String]? = nil)
    case parseError(String? = nil)    
}

extension SimctlError: AbortError {
    var reason: String {
        switch self {
        case .commandError(let command):
            let reason = "Unable execute simctl command"
            guard let command = command else {
                return reason
            }
            return "\(reason)\n\(command)"
        case .error(let message):
            let reason = "simctl command failed"
            guard let message = message else {
                return reason
            }
            return "\(reason):\n\(message)"
        case .missingRouteParameters(let missingParameters):
            let reason = "Missing one or more route parameters"
            guard let missingParameters = missingParameters else {
                return reason
            }
            return "\(reason): \(missingParameters.joined(separator: ", "))"
        case .parseError(let error):
            let reason = "Unable to parse simctl output"
            guard let error = error else {
                return reason
            }
            return "\(reason):\n\(error)"
        }
    }

    var status: HTTPStatus {
        switch self {
        case .commandError:
            return .internalServerError
        case .error:
            return .internalServerError
        case .missingRouteParameters:
            return .badRequest
        case .parseError:
            return .internalServerError
        }
    }
}
