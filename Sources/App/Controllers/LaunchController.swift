//
//  LaunchController.swift
//  
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// Launch an application by identifier on a device.
// Usage: simctl launch [-w | --wait-for-debugger] [--console|--console-pty] [--stdout=<path>] [--stderr=<path>] <device> <app bundle identifier> [<argv 1> <argv 2> ... <argv n>]
//
//    --console Block and print the application's stdout and stderr to the current terminal.
//        Signals received by simctl are passed through to the application.
//        (Cannot be combined with --stdout or --stderr)
//    --console-pty Block and print the application's stdout and stderr to the current terminal via a PTY.
//        Signals received by simctl are passed through to the application.
//        (Cannot be combined with --stdout or --stderr)
//    --stdout=<path> Redirect the application's standard output to a file.
//    --stderr=<path> Redirect the application's standard error to a file.
//        Note: Log output is often directed to stderr, not stdout.
//
// If you want to set environment variables in the resulting environment, set them in the calling environment with a SIMCTL_CHILD_ prefix.

class LaunchController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["launch"], use: launch)
    }
    
    func launch(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
