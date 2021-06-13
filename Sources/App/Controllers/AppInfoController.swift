//
//  AppInfoController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
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
        guard var output = String(data: shell("xcrun simctl appinfo \"\(device)\" \"\(bundleIdentifier)\""),
                                  encoding: .utf8) else {
            throw SimctlError.parseError()
        }
        output = output.chomp()
        
        return Response(status: .ok, body: .init(stringLiteral: output))
    }
}
