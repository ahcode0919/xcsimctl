//
//  File.swift
//  
//
//  Created by Aaron Hinton on 5/5/21.
//

import Foundation
import SwiftShell
import Vapor

//Shutdown a device.
//Usage: simctl shutdown <device> | all
//
//Specifying all will shut down all running devices

class ShutdownController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["shutdown", ":device"], use: shutdown)
        routes.post(["shutdown", "all"], use: shutdownAll)
    }
    
    func shutdown(_ req: Request) throws -> Response {
        guard let device = req.parameters.get("device") else {
            throw SimctlError.missingRouteParameters(["Device name"])
        }
        
        let args = ["simctl", "shutdown", device]
        
        guard let output = try Shell.execute(.xcrun, args: args)?.sanitize() else {
            throw SimctlError.parseError()
        }
        
        guard output.isEmpty else {
            throw SimctlError.error(output)
        }
        
        return Response(status: .ok)
    }
    
    func shutdownAll(_ req: Request) throws -> Response {
        let args = ["simctl", "shutdown", "all"]

        guard let output = try Shell.execute(.xcrun, args: args)?.sanitize() else {
            throw SimctlError.parseError()
        }
        
        guard output.isEmpty else {
            throw SimctlError.error(output)
        }
        
        return Response(status: .ok)
    }
}

