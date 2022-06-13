//
//  OpenURLController.swift
//  
//
//  Created by Aaron Hinton on 5/25/21.
//

import Foundation
import SwiftShell
import Vapor

// Open a URL in a device.
// Usage: simctl openurl <device> <URL>

class OpenURLController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["openurl", ":device"], use: openUrl)
    }
    
    func openUrl(_ req: Request) throws -> Response {
        guard let device = req.parameters.get("device") else {
            throw SimctlError.missingRouteParameters(["Device"])
        }
        guard let url = try? req.content.decode(OpenURLRequest.self).url else {
            throw SimctlError.missingRouteParameters(["URL"])
        }
        
        let args = ["simctl", "openurl", device, url]
        
        guard let output = try Shell.execute(.xcrun, args: args)?.sanitize() else {
            throw SimctlError.parseError()
        }
        
        guard output.isEmpty else {
            throw SimctlError.error(output)
        }
        
        return Response(status: .ok)
    }
}

