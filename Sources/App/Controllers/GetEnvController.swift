//
//  GetEnvController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// Print an environment variable from a running device.
// Usage: simctl getenv <device> <variable name>

class GetEnvController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["getenv"], use: getEnv)
    }
    
    func getEnv(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
