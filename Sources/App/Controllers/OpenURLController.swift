//
//  OpenURLController.swift
//  
//
//  Created by Aaron Hinton on 5/25/21.
//

import Foundation
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
        guard let url = try? req.content.decode(OpenURL.self).url else {
            throw SimctlError.missingRouteParameters(["URL"])
        }
        guard var output = String(data: shell("xcrun simctl openurl \"\(device)\" \"\(url)\""), encoding: .utf8) else {
            throw SimctlError.parseError()
        }
        output = output.chomp()
        
        guard output == "" else {
            throw SimctlError.error(output)
        }
        
        return Response(status: .ok)
    }
}

