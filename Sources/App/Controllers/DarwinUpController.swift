//
//  DarwinUpController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// Invoke darwinup to install a root for the specified simulator runtime.
// Usage: simctl darwinup [-fnsv] <platform> <command> [<archive> ...]
//
// options:
//    -f         Force operation to succeed at all costs.
//    -n         Dry run; prints arguments that would have been sent to darwinup.
//    -s         Use the SDK root path instead of the runtime root.
//    -v         More verbose output.
//
// <platform> is the Simulator platform, i.e. iphonesimulator, watchsimulator, appletvsimulator.
// (To target a runtime disk image, specify the path to that runtime instead. Invalid with -s).
//
// commands:
//    install    Install the roots specified by one or more <archive> arguments.
//    list       List the installed roots, with optional filter using <archive> arguments.
//    uninstall  Remove the roots specified by one or more <archive> arguments.
//
//    See darwinup usage for additional commands and more information.
//
// NOTE: If you install or uninstall roots, you must manually update the dyld_sim shared cache.
//      See simctl help runtime for information about triggering a dyld_sim shared cache rebuild.

class DarwinUpController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["darwinup"], use: darwinUp)
    }
    
    func darwinUp(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
