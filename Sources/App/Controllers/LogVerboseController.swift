//
//  LogVerboseController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// enable or disable verbose logging for a device
// Usage: simctl logverbose [<device>] (enable | disable)
//    <device>         The device. If not provided all booted devices are affected.
//    enable           Enables verbose logging
//    disable          Disables verbose logging
//
// NOTE: You may need to reboot the affected device before logging changes will be effective.

class LogVerboseController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["logverbose"], use: logVerbose)
    }
    
    func logVerbose(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
