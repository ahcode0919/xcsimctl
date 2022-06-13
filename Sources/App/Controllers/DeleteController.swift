//
//  DeleteController.swift
//  
//
//  Created by Aaron Hinton on 4/18/21.
//

import Fast
import SwiftShell
import Vapor

//Delete spcified devices, unavailable devices, or all devices.
//Usage: simctl delete <device> [... <device n>] | unavailable | all
//
//Specifying unavailable will delete devices that are not supported by the current Xcode SDK.

class DeleteController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post("delete", use: deleteDevices)
        routes.post(["delete", ":device"], use: delete)
        routes.post(["delete", "all"], use: deleteAll)
        routes.post(["delete", "unavailable"], use: deleteUnavailable)
    }
    
    func delete(_ req: Request) throws -> Response {
        guard let device = req.parameters.get("device") else {
            throw SimctlError.missingRouteParameters(["Device name"])
        }
        let args = ["simctl", "delete", device]

        guard let output = try Shell.execute(.xcrun, args: args)?.sanitize() else {
            throw SimctlError.parseError()
        }
        
        guard output.isEmpty else {
            throw SimctlError.error(output)
        }
        return Response(status: .ok)
    }
    
    func deleteAll(_ req: Request) throws -> Response {
        let args = ["simctl", "delete", "all"]

        guard let output = try Shell.execute(.xcrun, args: args)?.sanitize() else {
            throw SimctlError.parseError()
        }
        
        guard output.isEmpty else {
            throw SimctlError.error(output)
        }
        return Response(status: .ok)
    }
    
    func deleteDevices(_ req: Request) throws -> Response {
        var args = ["simctl", "delete"]
        let deleteQuery = try req.query.decode(DeleteQuery.self)

        guard let devices = deleteQuery.devices else {
                throw SimctlError.commandError()
        }
        
        for device in devices {
            args.append(device)
        }

        guard let output = try Shell.execute(.xcrun, args: args)?.sanitize() else {
            throw SimctlError.parseError()
        }
        
        guard output.isEmpty else {
            throw SimctlError.error(output)
        }
        return Response(status: .ok)
    }
    
    func deleteUnavailable(_ req: Request) throws -> Response {
        let args = ["simctl", "delete", "unavailable"]

        guard let output = try Shell.execute(.xcrun, args: args)?.sanitize() else {
            throw SimctlError.parseError()
        }
        
        guard output.isEmpty else {
            throw SimctlError.error(output)
        }
        return Response(status: .ok)
    }
}
