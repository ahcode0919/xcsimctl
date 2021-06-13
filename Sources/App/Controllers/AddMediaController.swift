//
//  AddMediaController.swift
//
//
//  Created by Aaron Hinton on 6/12/21.
//

import Foundation
import Vapor

class AddMediaController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(["addmedia"], use: addMedia)
        routes.post(["addphoto"], use: addPhoto)
        routes.post(["addvideo"], use: addVideo)
    }
    
    // Add photos, live photos, videos, or contacts to the library of a device.
    // Usage: simctl addmedia <device> <path> [... <path>]
    // You can specify multiple files including a mix of photos, videos, and contacts.
    // You can also specify multiple live photos by providing the photo and video files. They will automatically be discovered and imported correctly.
    // Contacts support the vCard format.
    func addMedia(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
    
    // Add photos to the photo library of a device.
    // Usage: simctl addphoto <device> <path> [... <path>]
    func addPhoto(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
    
    // Add videos to the photo library of a device.
    // Usage: simctl addvideo <device> <path> [... <path>]
    func addVideo(_ req: Request) throws -> Response {
        return Response(status: .notImplemented)
    }
}
