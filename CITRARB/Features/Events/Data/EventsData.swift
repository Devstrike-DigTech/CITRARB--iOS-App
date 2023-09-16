//
//  EventsData.swift
//  CITRARB
//
//  Created by Richard Uzor on 12/09/2023.
//

import Foundation

struct GetAllEvents: Codable{
    let status: String
    let length: Int
    let data: [Event]
}

struct Event: Codable{
    let _id: String
    let name: String
    let coHosts: [CoHost]
    let image: String?
    let time: String
    let location: String
    let host: Host
    let description: String
    let numberOfAttendee: Int
    let eventAttendance: [String]
    let id: String
}

struct CoHost: Codable{
    let _id: String
    let username: String
    let email: String
    let role: String
    let photo: String
    let createdAt: String
    let updatedAt: String
    let __v: Int
    
}

struct Host: Codable{
    let _id: String
    let username: String
    let email: String
    let role: String
    let photo: String
    let createdAt: String
    let updatedAt: String
    let __v: Int
    let gender: String?
    let phone: String?
}

struct IdentifiableEventListItem: Identifiable {
    let id: String
    let eventItem: Event
}

struct CreateEventResponse: Codable{
    let status: String
    let data: CreatedEvent
}

struct CreatedEvent: Codable{
    let name: String
    let coHosts: String
    let image: String
    let time: String
    let location: String
    let host: String
    let description: String
    let numberOfAttendee: String
    let eventAttendance: String
    let _id: String
    let __v: String
    let id: String
}

