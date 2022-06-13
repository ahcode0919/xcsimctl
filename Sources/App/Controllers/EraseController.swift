//
//  EraseController.swift
//  
//
//  Created by Aaron Hinton on 4/21/21.
//

import Fast
import SwiftShell
import Vapor

//Erase a device's contents and settings.
//Usage: simctl erase <device> [... <device n>] | all
//
//Specifying all will erase all existing devices.

class EraseController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post("erase", use: eraseDevices)
        routes.post(["erase", "all"], use: eraseAll)
        routes.post(["erase", ":device"], use: erase)
    }
    
    func erase(_ req: Request) throws -> Response {
        guard let device = req.parameters.get("device") else {
            throw SimctlError.missingRouteParameters(["device name"])
        }

        let args = ["simctl", "erase", device]

        guard let output = try Shell.execute(.xcrun, args: args)?.sanitize() else {
            throw SimctlError.parseError()
        }
        
        guard output.isEmpty else {
            throw SimctlError.error(output)
        }
        return Response(status: .ok)
    }
    
    func eraseAll(_ req: Request) throws -> Response {
        let args = ["simctl", "erase", "all"]

        guard let output = try Shell.execute(.xcrun, args: args)?.sanitize() else {
            throw SimctlError.parseError()
        }
        
        guard output.isEmpty else {
            throw SimctlError.error(output)
        }
        return Response(status: .ok)
    }
    
    func eraseDevices(_ req: Request) throws -> Response {
        var args = ["simctl", "erase"]
        let eraseQuery = try req.query.decode(EraseQuery.self)

        guard let devices = eraseQuery.devices else {
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
}
