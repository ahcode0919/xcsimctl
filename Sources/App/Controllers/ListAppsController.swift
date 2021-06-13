//
//  ListAppsController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// Show the installed applications.
// Usage: simctl listapps <device>

class ListAppsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["listapps"], use: listApps)
    }
    
    func listApps(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
