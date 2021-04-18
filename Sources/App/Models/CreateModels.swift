//
//  CreateModels.swift
//  
//
//  Created by Aaron Hinton on 4/15/21.
//

import Vapor

/// Create Query String
struct CreateQuery: Content {
    var runtime: String?
}

/// Create response
struct CreateResponse: Content {
    var uuid: UUID
}
