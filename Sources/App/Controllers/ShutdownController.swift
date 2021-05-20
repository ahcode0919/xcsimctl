//
//  File.swift
//  
//
//  Created by Aaron Hinton on 5/5/21.
//

import Foundation
import Vapor

//Shutdown a device.
//Usage: simctl shutdown <device> | all
//
//Specifying all will shut down all running devices

class ShutdownController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["shutdown", ":devicename"], use: shutdown)
        routes.post(["shutdown", "all"], use: shutdownAll)
    }
    
    func shutdown(_ req: Request) throws -> Response {
        guard let deviceName = req.parameters.get("devicename") else {
            throw SimctlError.missingRouteParameters(["Device name"])
        }
        guard var output = String(data: shell("xcrun simctl shutdown \"\(deviceName)\""), encoding: .utf8) else {
            throw SimctlError.parseError()
        }
        output = output.chomp()
        
        guard output == "" else {
            throw SimctlError.error(output)
        }
        
        return Response(status: .ok)
    }
    
    func shutdownAll(_ req: Request) throws -> Response {
        guard var output = String(data: shell("xcrun simctl shutdown all"), encoding: .utf8) else {
            throw SimctlError.parseError()
        }
        output = output.chomp()
        
        guard output == "" else {
            throw SimctlError.error(output)
        }
        
        return Response(status: .ok)
    }
}

