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

struct SendFriendRequestResponse: Codable{
    let status: String
    let data: FriendRequest
}

struct FriendRequest: Codable{
    let userId: String
    let requester: String
    let status: String
    let _id: String
    let __v: Int
}

struct GetFriendsResponse: Codable, Hashable{
    let status: String
    let length: Int
    let data: [FriendsList]
}

struct FriendsList: Codable, Hashable, Equatable{
    let _id: String
    let userId: String
    let friend: Friend
    let active: Bool
    let __v: Int
    
    // Implement Equatable protocol
      static func == (lhs: FriendsList, rhs: FriendsList) -> Bool {
          return lhs._id == rhs._id
      }
}

struct Friend: Codable, Hashable{
    let _id: String
    let username: String
    let photo: String
}

struct PendingFriendRequestsResponse: Codable{
    let status: String
    let data: [PendingFriendRequest]
}

struct PendingFriendRequest: Codable{
    let _id: String
    let userId: String
    let requester: FriendRequester
    let status: String
}

struct FriendRequester: Codable{
    let _id: String
    let username: String
    let photo: String
}
