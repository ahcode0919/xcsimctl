//
//  AppInfoController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import SwiftShell
import Vapor

// Show information about an installed application.
// Usage: simctl appinfo <device> <bundle identifier>

class AppInfoController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get(["appinfo", ":device", ":bundleId"], use: appInfo)
    }
    
    func appInfo(_ req: Request) throws -> Response {
        guard let device = req.parameters.get("device") else {
            throw SimctlError.missingRouteParameters(["Device name"])
        }
        guard let bundleIdentifier = req.parameters.get("bundleId") else {
            throw SimctlError.missingRouteParameters(["Bundle Identifier"])
        }

        let args = ["simctl", "appinfo", device, bundleIdentifier]
        
        guard let output = try Shell.execute(.xcrun, args: args)?.sanitize() else {
            throw SimctlError.parseError()
        }
        
        return Response(status: .ok, body: .init(stringLiteral: output))
    }
}
