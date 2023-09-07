//
//  ConnectData.swift
//  CITRARB
//
//  Created by Richard Uzor on 04/09/2023.
//

import Foundation
struct ConnectResponse: Codable, Hashable{
    let status: String
    let length: Int
    let data: [Connect]
}

struct Connect: Codable, Hashable, Identifiable{
    let _id: String
    let name: String
    let jobTitle: String
    let phone: String
    let category: String
    let description: String
    let userId: String
    
    var id: String { return _id } // Conform to Identifiable protocol
    // Implement Equatable protocol
      static func == (lhs: Connect, rhs: Connect) -> Bool {
          return lhs.name == rhs.name
      }
}

struct IdentifiableConnectListItem: Identifiable {
    let id: String
    let connectItem: Connect
}

struct NewConnectResponse: Codable, Hashable{
    let status: String
    let data: NewConnect
}
struct NewConnect: Codable, Hashable{
    let name: String
    let jobTitle: String
    let phone: String
    let category: String
    let description: String
    let userId: String
    let active: Bool
    let _id: String
    let __v: Int
    
}
