//
//  File.swift
//  
//
//  Created by Aaron Hinton on 4/18/21.
//

import Foundation
import Vapor

struct ErrorResponse: Content {
    var error: Bool?
    var reason: String?
}
