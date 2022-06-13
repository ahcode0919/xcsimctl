//
//  ErrorResponse.swift
//  
//
//  Created by Aaron Hinton on 6/12/22.
//

import Vapor

/// JSON object for thrown errors
struct ErrorResponse: Content {
    let error: Bool
    let reason: String
}
