//
//  TerminateController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// Terminate an application by identifier on a device.
// Usage: simctl terminate <device> <app bundle identifier>

class TerminateController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["terminate"], use: terminate)
    }
    
    func terminate(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
