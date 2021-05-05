//
//  BootController.swift
//  
//
//  Created by Aaron Hinton on 5/4/21.
//

import Foundation
import Vapor

//Boot a device.
//Usage: simctl boot <device> [-disabledJob=<job>] [--disabledJob=<job>]
//
//    --disabledJob=<job>     Disables the given launchd job. Multiple jobs can be disabled by passing multiple flags.
//    --enabledJob=<job>      Enables the given launchd job when it would normally be disabled.
//                            Multiple jobs can be enabled by passing multiple flags.
//
//
//If you want to set environment variables in the resulting environment, set them in the calling environment with a SIMCTL_CHILD_ prefix.

class BootController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["boot", ":devicename"], use: boot)
    }
    
    func boot(_ req: Request) throws -> Response {
        guard let deviceName = req.parameters.get("devicename") else {
            throw SimctlError.missingRouteParameters(["Device name"])
        }
        guard var output = String(data: shell("xcrun simctl boot \"\(deviceName)\""), encoding: .utf8) else {
            throw SimctlError.parseError()
        }
        output = output.chomp()
        
        guard output == "" else {
            throw SimctlError.error(output)
        }
        
        return Response(status: .ok)
    }
}

