//
//  CreateController.swift
//
//
//  Created by Aaron Hinton on 4/15/21.
//

import Foundation
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

struct CreateController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["create", ":name", ":devicetype"], use: create)
    }
    
    /// create/:name/:devicetype?runtime
    func create(_ req: Request) throws -> CreateResponse {
        guard let name = req.parameters.get("name"), let devicetype = req.parameters.get("devicetype") else {
            throw SimctlError.missingRouteParameters(["name", "devicetype"])
        }

        var command = "xcrun simctl create \"\(name)\" \"\(devicetype)\""
        if let runtime = try? req.query.decode(CreateQuery.self).runtime {
            command.append(" \(runtime)")
        }

        let output = shell(command)
        guard var outputString = String(data: output, encoding: .utf8) else {
            throw SimctlError.parseError()
        }
        
        if outputString.contains("No runtime specified") {
            let outputStrings = outputString.split(separator: "\n")
            guard outputStrings.count > 1 else {
                throw SimctlError.parseError()
            }
            outputString = String(outputStrings[1])
        }
        
        guard let deviceUUID = UUID(uuidString: outputString.trimmingCharacters(in: .whitespacesAndNewlines)) else {
            if let outputString = String(data: output, encoding: .utf8) {
                throw SimctlError.commandError("\(CreateError.findError(outputString).message)")
            }
            throw SimctlError.commandError(CreateError.createError.message)
        }
        return CreateResponse(uuid: deviceUUID)
    }
}
