//
//  SpawnController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// Spawn a process by executing a given executable on a device.
// Usage: simctl spawn [-w | --wait-for-debugger] [-s | --standalone] [-a <arch> |
// --arch=<arch>] <device> <path to executable> [<argv 1> <argv 2> ... <argv n>]
//
// The path to the executable is searched using the following rules:
//   <path> contains no / characters: search the device's $PATH. This is similar to how most shells work, but searches
//          the device's path instead of the host's path.
//   <path> starts with /: Assume a literal path to the binary. This must start from the host's root.
//   <path> contains non-leading / characters: search relative to the current directory first, then
//          relative to the device's $SIMULATOR_ROOT.
//
// If you want to set environment variables in the resulting environment, set them in the calling environment with a
// SIMCTL_CHILD_ prefix.

class SpawnController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["spawn"], use: spawn)
    }
    
    func spawn(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
