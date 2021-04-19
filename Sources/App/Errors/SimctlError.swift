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
        case .commandError(let message):
            let reason = "Unable execute simctl command"
            guard let message = message else {
                return reason
            }
            return "\(reason): \(message)"
        case .error(let message):
            let reason = "simctl command failed"
            guard let message = message else {
                return reason
            }
            return "\(reason): \"\(message)\""
        case .missingRouteParameters(let missingParameters):
            guard let missingParameters = missingParameters else {
                return "Missing one or more route parameters"
            }
            var message = "Missing the following route parameter"
            if missingParameters.count > 1 {
                message.append("s")
            }
            return "\(message): \(missingParameters.joined(separator: ", "))"
        case .parseError(let error):
            let reason = "Unable to parse simctl output"
            guard let error = error else {
                return reason
            }
            return "\(reason): \(error)"
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
