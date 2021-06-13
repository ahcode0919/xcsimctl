//
//  IOController.swift
//  
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

// Set up a device IO operation.
// Usage: simctl io <device> <operation> <arguments>
//
// Supported operations:
//    enumerate [--poll]
//        Lists all available IO ports and descriptor states.
//        --poll       Poll after enumeration.
//
//    poll
//        Polls all available IO ports for events.
//
//    recordVideo [--codec=<codec>] [--display=<display>] [--mask=<policy>] [--force] <file or url>
//        Records the display to a QuickTime movie at the specified file or url.
//        --codec      Specifies the codec type: "h264" or "hevc". Default is "hevc".
//
//        --display    iOS: supports "internal" or "external". Default is "internal".
//                     tvOS: supports only "external"
//                     watchOS: supports only "internal"
//
//        --mask       For non-rectangular displays, handle the mask by policy:
//                     ignored: The mask is ignored and the unmasked framebuffer is saved.
//                     alpha: Not supported, but retained for compatibility; the mask is rendered black.
//                     black: The mask is rendered black.
//
//        --force      Force the output file to be written to, even if the file already exists.
//
//    screenshot [--type=<type>] [--display=<display>] [--mask=<policy>] <file or url>
//        Saves a screenshot as a PNG to the specified file or url(use "-" for stdout).
//        --type       Can be "png", "tiff", "bmp", "gif", "jpeg". Default is png.
//
//        --display    iOS: supports "internal" or "external". Default is "internal".
//                     tvOS: supports only "external"
//                     watchOS: supports only "internal"
//
//                     You may also specify a port by UUID
//        --mask       For non-rectangular displays, handle the mask by policy:
//                     ignored: The mask is ignored and the unmasked framebuffer is saved.
//                     alpha: The mask is used as premultiplied alpha.
//                     black: The mask is rendered black.
//
// Example:
//    Save a screenshot of the booted device to screenshot.png:
//    simctl io booted screenshot screenshot.png

class IOController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["io"], use: io)
    }
    
    func io(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
