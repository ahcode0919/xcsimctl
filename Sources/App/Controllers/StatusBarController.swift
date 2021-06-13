//
//  StatusBarController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// Set or clear status bar overrides
// Usage: simctl status_bar <device> [list | clear | override <override arguments>]
//
// Supported Operations:
//    list
//    List existing overrides.
//
//    clear
//    Clear all existing status bar overrides.
//
//    override <override arguments>
//    Set status bar override values, according to these flags.
//    You may specify any combination of these flags (at least one is required):
//
//    --time <string>
//         Set the date or time to a fixed value.
//         If the string is a valid ISO date string it will also set the date on relevant devices.
//    --dataNetwork <dataNetworkType>
//         If specified must be one of 'wifi', '3g', '4g', 'lte', 'lte-a', or 'lte+'.
//    --wifiMode <mode>
//         If specified must be one of 'searching', 'failed', or 'active'.
//    --wifiBars <int>
//         If specified must be 0-3.
//    --cellularMode <mode>
//         If specified must be one of 'notSupported', 'searching', 'failed', or 'active'.
//    --cellularBars <int>
//         If specified must be 0-4.
//    --operatorName <string>
//         Set the cellular operator/carrier name. Use '' for the empty string.
//    --batteryState <state>
//         If specified must be one of 'charging', 'charged', or 'discharging'.
//    --batteryLevel <int>
//         If specified must be 0-100.

class StatusBarController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["statusbar"], use: statusBar)
    }
    
    func statusBar(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
