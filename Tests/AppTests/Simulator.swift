//
//  Simulator.swift
//  
//
//  Created by Aaron Hinton on 6/11/22.
//

import Foundation

struct Simulator {
    let device: TestDevice
    let type: SimulatorType
    
    enum SimulatorType {
        case custom(String)
        case iPhone8
        
        var name: String {
            switch self {
            case .custom(let name):
                return name
            case .iPhone8:
                return "iPhone 8"
            }
        }
    }
}
