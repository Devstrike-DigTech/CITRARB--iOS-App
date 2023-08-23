//
//  MembersData.swift
//  CITRARB
//
//  Created by Richard Uzor on 23/08/2023.
//

import Foundation

struct MembersListResponse: Codable, Hashable {
    let status: String
    let members: [Member]
}


struct Member: Identifiable, Codable, Hashable, Equatable {
    let _id: String
    let username: String
    let email: String
    let role: String
    let photo: String
    let createdAt: String
    let updatedAt: String
    let __v: Int
    
    var id: String { return _id } // Conform to Identifiable protocol
    // Implement Equatable protocol
      static func == (lhs: Member, rhs: Member) -> Bool {
          return lhs.username == rhs.username
      }

    
    // Implement Equatable protocol
//      static func == (lhs: Member, rhs: Member) -> Bool {
//          return lhs._id == rhs._id
//      }
}


struct IdentifiableMemberListItem: Identifiable {
    let id: String
    let memberItem: Member
}
