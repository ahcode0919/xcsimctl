//
//  PushController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// Send a simulated push notification
// Usage: simctl push <device> [<bundle identifier>] (<json file> | -)
//
//    bundle identifier
//         The bundle identifier of the target application
//         If the payload file contains a 'Simulator Target Bundle' top-level key this parameter may be omitted.
//         If both are provided this argument will override the value from the payload.
//    json file
//         Path to a JSON payload or '-' to read from stdin. The payload must:
//           - Contain an object at the top level.
//           - Contain an 'aps' key with valid Apple Push Notification values.
//           - Be 4096 bytes or less.
//
// Only application remote push notifications are supported. VoIP, Complication, File Provider, and other types are not supported.

class PushController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["push"], use: push)
    }
    
    func push(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
