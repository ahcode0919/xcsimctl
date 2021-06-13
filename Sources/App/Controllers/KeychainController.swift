//
//  KeychainController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// Manipulate a device's keychain
// Usage: simctl keychain <device> <action> [arguments]
//
//    add-root-cert [path]
//        Add a certificate to the trusted root store.
//
//    add-cert [path]
//        Add a certificate to the keychain.
//
//    reset
//        Reset the keychain.

class KeychainController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["keychain"], use: keychain)
    }
    
    func keychain(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
