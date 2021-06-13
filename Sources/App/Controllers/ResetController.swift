//
//  ResetController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// Reset a given archive or database.
// Usage: simctl reset <device> <subsystem>
//
// Supported Subsystems:
// launch_services

class ResetController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["reset"], use: reset)
    }
    
    func reset(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
