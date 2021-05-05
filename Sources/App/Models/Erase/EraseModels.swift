//
//  File.swift
//  
//
//  Created by Aaron Hinton on 4/21/21.
//

import Vapor

struct EraseQuery: Content {
    var devices: [String]?
    
    enum CodingKeys: String, CodingKey {
        case devices
    }
}

extension EraseQuery {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let devicesString: String = try values.decode(String.self, forKey: .devices)
        devices = devicesString.split(separator: ",").map { String($0) }
    }
}
