//
//  PairController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

class PairController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["pair"], use: pair)
        routes.post(["pair", "activate"], use: activate)
    }
    
    // Set a given pair as active.
    // Usage: simctl pair_activate <pair>
    func activate(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
    
    // Create a new watch and phone pair.
    // Usage: simctl pair <watch device> <phone device>
    func pair(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
