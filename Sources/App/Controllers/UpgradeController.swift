//
//  UpgradeController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// Upgrade a device to a newer runtime.
// Usage: simctl upgrade <device> <runtime id>

class UpgradeController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["upgrade"], use: upgrade)
    }
    
    func upgrade(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
