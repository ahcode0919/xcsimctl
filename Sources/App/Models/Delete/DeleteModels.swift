//
//  DeleteModels.swift
//  
//
//  Created by Aaron Hinton on 4/18/21.
//

import Vapor

struct DeleteQuery: Content {
    var devices: [String]?
    
    enum CodingKeys: String, CodingKey {
        case devices
    }
}

extension DeleteQuery {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let devicesString: String = try values.decode(String.self, forKey: .devices)
        devices = devicesString.split(separator: ",").map { String($0) }
    }
}
