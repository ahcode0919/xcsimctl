//
//  CloneController.swift
//  
//
//  Created by Aaron Hinton on 5/1/21.
//

import Foundation
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
        guard var output = String(data: shell("xcrun simctl clone \"\(deviceName)\" \"\(newDeviceName)\""), encoding: .utf8) else {
            throw SimctlError.parseError()
        }
        output = output.chomp()
        
        guard let uuid = UUID(uuidString: output) else {
            throw SimctlError.parseError("Couldn't not parse device UUID")
        }
        
        return CloneResponse(uuid: uuid)
    }
}
