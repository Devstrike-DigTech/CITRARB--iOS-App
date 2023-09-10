//
//  Data+Extensions.swift
//  CITRARB
//
//  Created by Richard Uzor on 09/09/2023.
//

import Foundation

extension Data {
    
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
