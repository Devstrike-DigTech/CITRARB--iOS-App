//
//  EyeWitnessData.swift
//  CITRARB
//
//  Created by Richard Uzor on 16/09/2023.
//

import Foundation

struct GetAllEyeWitnessResponse: Codable{
    let status: String
    let length: Int
    let data: [EyeWitnessReport]
}

struct EyeWitnessReport: Codable{
    let _id: String
    let video: String
    let images: [String]
    let location: String
    let userId: Reporter
    let title: String
    let isVerified: Bool
    let createdAt: String
    let updatedAt: String
    let reactions: [String]
    let id: String
    
}

struct Reporter: Codable{
    let _id: String
    let username: String
    let email: String
    let role: String
    let photo: String
    let phone: String?
    let createdAt: String
    let updatedAt: String
    let __v: Int
}


struct IdentifiableReportListItem: Identifiable {
    let id: String
    let eyeWitnessItem: EyeWitnessReport
}

struct CreateEyeWitnessReport: Codable{
    let status: String
    let data: CreatedReport
}

struct CreatedReport: Codable{
    let video: String
    let images: [String]
    let location: String
    let userId: String
    let title: String
    let isVerified: Bool
    let _id: String
    let createdAt: String
    let updatedAt: String
    let __v: Int
    let id: String
}
