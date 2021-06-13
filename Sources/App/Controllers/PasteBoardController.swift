//
//  PasteBoardController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

class PasteBoardController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["pbcopy"], use: pbCopy)
        routes.get(["pbinfo"], use: pbInfo)
        routes.get(["pbpaste"], use: pbPaste)
        routes.post(["pbsync"], use: pbSync)
    }
    
    // Copy standard input onto the device pasteboard.
    // Usage: simctl pbcopy [-v] <device or "host">
    func pbCopy(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
    
    // Print information about the device's pasteboard
    // Usage: simctl pbinfo <device or "host">
    func pbInfo(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
    
    // Print the contents of the device's pasteboard to standard output.
    // Usage: simctl pbpaste [-v] <device or "host">
    func pbPaste(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
    
    // Sync the pasteboard content from one pasteboard to another.
    // Usage: simctl pbsync [-pv] <source device or "host"> <destination device or "host">

    // -p causes simctl to use promise data for secondary types.  simctl will continue to run to
    // provide that promise data until something else replaces it on the pasteboard.
    func pbSync(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
