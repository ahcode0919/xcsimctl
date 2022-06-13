//
//  SimctlResponse.swift
//  
//
//  Created by Aaron Hinton on 6/12/22.
//

import Vapor

struct SimctlResponse: Content {
    let simctlOutput: String?
    
    enum CodingKeys: String, CodingKey {
        case simctlOutput = "simctl_output"
    }
}
