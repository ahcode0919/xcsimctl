//
//  File.swift
//  
//
//  Created by Aaron Hinton on 5/20/21.
//

import Foundation
import SwiftShell
import Vapor

// Rename a device.
// Usage: simctl rename <device> <name>

class RenameController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["rename", ":devicename", ":newname"], use: rename)
    }
    
    func rename(_ req: Request) throws -> Response {
        guard let deviceName = req.parameters.get("devicename") else {
            throw SimctlError.missingRouteParameters(["Device name"])
        }
        guard let newName = req.parameters.get("newname") else {
            throw SimctlError.missingRouteParameters(["New name"])
        }
        
        let args = ["simctl", "rename", deviceName, newName]
        
        guard let output = try Shell.execute(.xcrun, args: args)?.sanitize() else {
            throw SimctlError.parseError()
        }
        
        guard output.isEmpty else {
            throw SimctlError.error(output)
        }
        
        return Response(status: .ok)
    }
}

