//
//  MusicData.swift
//  CITRARB
//
//  Created by Richard Uzor on 13/09/2023.
//

import Foundation

struct GetAllMusicResponse: Codable{
    let status: String
    let length: Int
    let data: [Music]
    
}

struct Music: Codable{
    let _id: String
    let file: String
    let title: String
    let userId: MusicOwner
    let description: String
    let isVerified: Bool
    let image: String
    let createdAt: String
    let updatedAt: String
    let reactions: [String]
    let id: String
}


struct IdentifiableMusicListItem: Identifiable {
    let id: String
    let musicItem: Music
}

struct MusicOwner: Codable{
    let _id: String
    let username: String
    let email: String
    let role: String
    let photo: String
    let phone: String?
    let gender: String?
    let createdAt: String
    let updatedAt: String
    let __v: Int
}

struct CreateMusicResponse: Codable{
    let status: String
    let data: CreatedMusic
}

struct CreatedMusic: Codable{
    let file: String
    let title: String
    let userId: String
    let description: String
    let isVerified: Bool
    let image: String
    let _id: String
    let createdAt: String
    let updatedAt: String
    let __v: Int
    let id: String
}
