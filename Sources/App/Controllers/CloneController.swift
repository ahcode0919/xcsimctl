//
//  CloneController.swift
//  
//
//  Created by Aaron Hinton on 5/1/21.
//

import Foundation
import SwiftShell
import Vapor
//
//Clone an existing device.
//Usage: simctl clone <device> <new name> [<destination device set>]

class CloneController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["clone", ":devicename", ":newdevicename"], use: clone)
    }
    
    func clone(_ req: Request) throws -> CloneResponse {
        guard let deviceName = req.parameters.get("devicename") else {
            throw SimctlError.missingRouteParameters(["Device name"])
        }
        guard let newDeviceName = req.parameters.get("newdevicename") else {
            throw SimctlError.missingRouteParameters(["New device name"])
        }
        
        let args = ["simctl", "clone", deviceName, newDeviceName]
        
        guard let output = try Shell.execute(.xcrun, args: args)?.sanitize() else {
            throw SimctlError.parseError()
        }
        
        guard let uuid = UUID(uuidString: output) else {
            throw SimctlError.parseError("Couldn't not parse device UUID")
        }
        
        return CloneResponse(uuid: uuid)
    }
}
