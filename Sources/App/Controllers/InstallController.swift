//
//  InstallController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// Install an app on a device.
// Usage: simctl install <device> <path>

class InstallController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["install"], use: install)
    }
    
    func install(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
