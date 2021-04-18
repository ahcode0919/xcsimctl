//
//  URLHelper.swift
//  
//
//  Created by Aaron Hinton on 4/18/21.
//

import Foundation

struct URLHelper {
    fileprivate static let urlPathCharSet = CharacterSet.urlPathAllowed.union(.urlQueryAllowed)
    
    static func escape(url: String) throws -> String {
        guard let escapedPath = url.addingPercentEncoding(withAllowedCharacters: Self.urlPathCharSet) else {
            throw NSError()
        }
        return escapedPath
    }
}
