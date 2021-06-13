//
//  iCloudSyncController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// Trigger iCloud sync on a device.
// Usage: simctl icloud_sync <device>

class ICloudSyncController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["icloudsync"], use: iCloudSync)
    }
    
    func iCloudSync(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
