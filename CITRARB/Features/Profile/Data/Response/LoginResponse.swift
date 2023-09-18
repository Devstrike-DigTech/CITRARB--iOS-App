//
//  LoginResponse.swift
//  CITRARB
//
//  Created by Richard Uzor on 03/08/2023.
//

import Foundation

struct LoginResponse: Codable{
    
    let status: String
    let token: String
    let user: User
    let occupation: Occupation
}

struct User: Codable {
    let _id: String
    let username: String
    let email: String
    let role: String
    let photo: String
    let createdAt: String
    let updatedAt: String
    let __v: Int
}

struct Occupation: Codable {
    // Add any properties specific to the Occupation here
}


struct SignupResponse: Codable{
    
    let status: String
    let token: String
    let user: User
}

struct SignupUser: Codable {
    let _id: String
    let username: String
    let email: String
    let role: String
    let photo: String
    let createdAt: String
    let updatedAt: String
    let __v: Int
    let active: Bool
}

struct GetMeResponse: Codable{
    let status: String
    let user: ProfileUser
    let occupation: ProfileOccupation
}

struct ProfileUser: Codable{
    let _id: String
    let username: String
    let email: String
    let role: String
    let photo: String
    let gender: String?
    let phone: String?
    let createdAt: String
    let updatedAt: String
    let __v: Int
}

let ProfileOccupation: Codable{
    let _id: String
    let name: String
    let jobTitle: String
    let phone: String
    let category: String
    let description: String
    let userId: String
    let __v: Int
}




