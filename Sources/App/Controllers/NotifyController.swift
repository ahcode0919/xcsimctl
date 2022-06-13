//
//  NotifyController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

class NotifyController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["notifypost"], use: notifyPost)
        routes.get(["notifystate"], use: notifyGetState)
        routes.post(["notifystate"], use: notifySetState)
    }

    // Set the state value of a darwin notification on a device.
    // Usage: simctl notify_get_state <device> <notification name>
    func notifyGetState(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
    
    // Post a darwin notification on a device.
    // Usage: simctl notify_post <device> <notification name>
    func notifyPost(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
    
    // Get the state value of a darwin notification on a device.
    // Usage: simctl notify_set_state <device> <notification name> <state>
    func notifySetState(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
