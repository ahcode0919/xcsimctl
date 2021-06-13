//
//  PrivacyController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// Grant, revoke, or reset privacy and permissions
// Usage: simctl privacy <device> <action> <service> [<bundle identifier>]
//
//    action
//         The action to take:
//             grant - Grant access without prompting. Requires bundle identifier.
//             revoke - Revoke access, denying all use of the service. Requires bundle identifier.
//             reset - Reset access, prompting on next use. Bundle identifier optional.
//         Some permission changes will terminate the application if running.
//    service
//         The service:
//             all - Apply the action to all services.
//             calendar - Allow access to calendar.
//             contacts-limited - Allow access to basic contact info.
//             contacts - Allow access to full contact details.
//             location - Allow access to location services when app is in use.
//             location-always - Allow access to location services at all times.
//             photos-add - Allow adding photos to the photo library.
//             photos - Allow full access to the photo library.
//             media-library - Allow access to the media library.
//             microphone - Allow access to audio input.
//             motion - Allow access to motion and fitness data.
//             reminders - Allow access to reminders.
//             siri - Allow use of the app with Siri.
//    bundle identifier
//         The bundle identifier of the target application.
//
// Examples:
//    reset all permissions: privacy <device> reset all
//    grant test host photo permissions: privacy <device> grant photos com.example.app.test-host
//
// Warning:
// Normally applications must have valid Info.plist usage description keys and follow the API guidelines to request
// access to services. Using this command to bypass those requirements can mask bugs.

class PrivacyController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["privacy"], use: privacy)
    }
    
    func privacy(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
