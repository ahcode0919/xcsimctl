//
//  CreateController.swift
//
//
//  Created by Aaron Hinton on 4/15/21.
//

import Foundation
import SwiftShell
import Vapor

//Usage: simctl create <name> <device type id> [<runtime id>]
//
//<device type id>    A valid available device type. Find these by running "xcrun simctl list devicetypes".
//                    Examples: ("iPhone X", "com.apple.CoreSimulator.SimDeviceType.iPhone-X")
//<runtime id>        A valid and available runtime. Find these by running "xcrun simctl list runtimes".
//                    If no runtime is specified the newest runtime compatible with the device type is chosen.
//                    Examples: ("watchOS3", "watchOS3.2", "watchOS 3.2",
//                              "com.apple.CoreSimulator.SimRuntime.watchOS-3-2",
//                              "/Volumes/path/to/Runtimes/watchOS 3.2.simruntime")
// Error Responses:
// Invalid device type: X
// Invalid runtime: X
// Unable to create a device for device type: X, runtime: X
// An error was encountered processing the command (domain=com.apple.CoreSimulator.SimError, code=163):
// Incompatible device

class CreateController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["create", ":name", ":devicetype"], use: create)
    }
    
    /// create/:name/:devicetype?runtime
    func create(_ req: Request) throws -> CreateResponse {
        guard let name = req.parameters.get("name"), let devicetype = req.parameters.get("devicetype") else {
            throw SimctlError.missingRouteParameters(["name", "devicetype"])
        }

        var command = ["simctl", "create", name, devicetype]
        if let runtime = try? req.query.decode(CreateQuery.self).runtime {
            command.append(runtime)
        }
        
        guard var outputString = try Shell.execute(.xcrun, args: command)?.sanitize() else {
            throw SimctlError.parseError()
        }
        
        if outputString.contains("No runtime specified") {
            guard let udid = outputString.split(separator: "\n").last else {
                throw SimctlError.parseError()
            }
            outputString = String(udid)
        }
        
        guard let deviceUUID = UUID(uuidString: outputString.chomp()) else {
            if outputString.isEmpty {
                throw SimctlError.commandError(CreateError.createError.message)
            }
            throw SimctlError.commandError("\(CreateError.findError(outputString).message)")
        }
        return CreateResponse(uuid: deviceUUID)
    }
}
