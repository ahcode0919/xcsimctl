//
//  GetAppController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// Print the path of the installed app's container
// Usage: simctl get_app_container <device> <app bundle identifier> [<container>]
//
// container   Optionally specify the container. Defaults to app.
//  app                 The .app bundle
//  data                The application's data container
//  groups              The App Group containers
//  <group identifier>  A specific App Group container

class GetAppController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["getappcontainer"], use: getAppContainer)
    }
    
    func getAppContainer(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
