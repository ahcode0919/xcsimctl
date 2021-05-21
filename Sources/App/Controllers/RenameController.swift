//
//  File.swift
//  
//
//  Created by Aaron Hinton on 5/20/21.
//

import Foundation
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
        guard var output = String(data: shell("xcrun simctl rename \"\(deviceName)\" \"\(newName)\""),
                                  encoding: .utf8) else {
            throw SimctlError.parseError()
        }
        output = output.chomp()
        
        guard output == "" else {
            throw SimctlError.error(output)
        }
        
        return Response(status: .ok)
    }
}

