//
//  EraseController.swift
//  
//
//  Created by Aaron Hinton on 4/21/21.
//

import Vapor

//Erase a device's contents and settings.
//Usage: simctl erase <device> [... <device n>] | all
//
//Specifying all will erase all existing devices.

class EraseController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post("erase", use: eraseDevices)
        routes.post(["erase", "all"], use: eraseAll)
        routes.post(["erase", ":devicename"], use: erase)
    }
    
    func erase(_ req: Request) throws -> Response {
        guard let device = req.parameters.get("devicename") else {
            throw SimctlError.missingRouteParameters(["device name"])
        }
        guard var output = String(data: shell("xcrun simctl erase \"\(device)\""), encoding: .utf8) else {
            throw SimctlError.parseError()
        }
        output = output.chomp()
        
        guard output == "" else {
            throw SimctlError.error(output)
        }
        return Response(status: .ok)
    }
    
    func eraseAll(_ req: Request) throws -> Response {
        guard var output = String(data: shell("xcrun simctl erase all"), encoding: .utf8) else {
            throw SimctlError.parseError()
        }
        output = output.chomp()
        
        guard output == "" else {
            throw SimctlError.error(output)
        }
        return Response(status: .ok)
    }
    
    func eraseDevices(_ req: Request) throws -> Response {
        var command = "xcrun simctl erase"
        guard let eraseQuery = try? req.query.decode(EraseQuery.self) else {
                throw SimctlError.commandError()
        }
        
        for device in eraseQuery.devices ?? [] {
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
}
