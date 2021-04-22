//
//  DeleteController.swift
//  
//
//  Created by Aaron Hinton on 4/18/21.
//

import Foundation
import Vapor

//Delete spcified devices, unavailable devices, or all devices.
//Usage: simctl delete <device> [... <device n>] | unavailable | all
//
//Specifying unavailable will delete devices that are not supported by the current Xcode SDK.

class DeleteController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post("delete", use: deleteDevices)
        routes.post(["delete", ":devicename"], use: delete)
        routes.post(["delete", "all"], use: deleteAll)
        routes.post(["delete", "unavailable"], use: deleteUnavailable)
    }
    
    func delete(_ req: Request) throws -> Response {
        guard let device = req.parameters.get("devicename") else {
            throw SimctlError.missingRouteParameters(["Device name"])
        }
        guard var output = String(data: shell("xcrun simctl delete \"\(device)\""), encoding: .utf8) else {
            throw SimctlError.parseError()
        }
        output = output.chomp()
        
        guard output == "" else {
            throw SimctlError.error(output)
        }
        return Response(status: .ok)
    }
    
    func deleteAll(_ req: Request) throws -> Response {
        guard var output = String(data: shell("xcrun simctl delete all"), encoding: .utf8) else {
            throw SimctlError.parseError()
        }
        output = output.chomp()
        
        guard output == "" else {
            throw SimctlError.error(output)
        }
        return Response(status: .ok)
    }
    
    func deleteDevices(_ req: Request) throws -> Response {
        var command = "xcrun simctl delete"
        guard let deleteQuery = try? req.query.decode(DeleteQuery.self) else {
                throw SimctlError.commandError()
        }
        
        for device in deleteQuery.devices ?? [] {
            command.append(" \"\(device)\"")
        }

        guard var output = String(data: shell(command), encoding: .utf8) else {
            throw SimctlError.parseError()
        }
        output = output.chomp()
        
        guard output == "" else {
            throw SimctlError.error(output)
        }
        return Response(status: .ok)
    }
    
    func deleteUnavailable(_ req: Request) throws -> Response {
        guard var output = String(data: shell("xcrun simctl delete unavailable"), encoding: .utf8) else {
            throw SimctlError.parseError()
        }
        output = output.chomp()
        
        guard output == "" else {
            throw SimctlError.error(output)
        }
        return Response(status: .ok)
    }
}
