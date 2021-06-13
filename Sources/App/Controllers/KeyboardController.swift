//
//  KeyboardController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// Set the device's keyboard language.
// Usage: simctl keyboard <device> <language>

class KeyboardController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["keyboard"], use: keyboard)
    }
    
    func keyboard(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
