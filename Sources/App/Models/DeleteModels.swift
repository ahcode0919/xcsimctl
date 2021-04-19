//
//  DeleteModels.swift
//  
//
//  Created by Aaron Hinton on 4/18/21.
//

import Vapor

struct DeleteQuery: Content {
    var named: [String]?
    
    enum CodingKeys: String, CodingKey {
        case named
    }
}

extension DeleteQuery {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let nameString: String = try values.decode(String.self, forKey: .named)
        named = nameString.split(separator: ",").map { String($0) }
    }
}
