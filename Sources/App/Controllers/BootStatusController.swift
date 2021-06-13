//
//  BootStatusController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

class BootStatusController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get(["bootstatus"], use: bootStatus)
    }
    
    // xcrun simctl bootstatus :device
    func bootStatus(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
