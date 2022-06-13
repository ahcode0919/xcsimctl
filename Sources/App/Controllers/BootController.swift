//
//  BootController.swift
//  
//
//  Created by Aaron Hinton on 5/4/21.
//

import Foundation
import SwiftShell
import Vapor

//Boot a device.
//Usage: simctl boot <device> [-disabledJob=<job>] [--disabledJob=<job>]
//
//    --disabledJob=<job>     Disables the given launchd job. Multiple jobs can be disabled by passing multiple flags.
//    --enabledJob=<job>      Enables the given launchd job when it would normally be disabled.
//                            Multiple jobs can be enabled by passing multiple flags.
//
//
// If you want to set environment variables in the resulting environment,
// set them in the calling environment with a SIMCTL_CHILD_ prefix.

class BootController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["boot", ":device"], use: boot)
    }
    
    func boot(_ req: Request) throws -> SimctlResponse {
        guard let device = req.parameters.get("device") else {
            throw SimctlError.missingRouteParameters(["Device name"])
        }
        
        let args = ["simctl", "boot", device]
        
        guard let output = try Shell.execute(.xcrun, args: args)?.sanitize() else {
            throw SimctlError.parseError()
        }
        
        if output.isEmpty {
            return SimctlResponse(simctlOutput: nil)
        }
        
        return SimctlResponse(simctlOutput: output)
    }
}

