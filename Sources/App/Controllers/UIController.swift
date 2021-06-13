//
//  UIController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// Get or Set UI options
// Usage: simctl ui <device> <option> [<arguments>]
//
// Supported Options:
//    appearance
//    When invoked without arguments prints the current user interface appearance style:
//         light
//         The Light appearance style.
//         dark
//         The Dark appearance style.
//         unsupported
//         The platform or runtime version do not support appearance styles.
//         unknown
//         The current style is unknown or there was an error detecting it.
//
//    appearance [light | dark]
//    Set the user interface apperance style to light or dark.

class UIController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["ui"], use: ui)
    }
    
    func ui(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
