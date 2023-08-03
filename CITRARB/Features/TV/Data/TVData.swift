//
//  TVData.swift
//  CITRARB
//
//  Created by Richard Uzor on 19/07/2023.
//

import Foundation

struct TVListResponse: Codable, Hashable {
    let data: [TVListItem]
    let fromCache: Bool
    let total: Int
}

struct TVListItem: Codable, Hashable, Equatable{//}, Identifiable {
    //var id = UUID()
    
    let Link: String
    let description: String
    let publishedAt: String
    var thumbnails: Thumbnails
    let title: String
    
    
    // Implement Equatable protocol
      static func == (lhs: TVListItem, rhs: TVListItem) -> Bool {
          return lhs.title == rhs.title
      }
}

struct Thumbnails: Codable, Hashable {
    var `default`: Metric?
    let high: Metric?
    let maxres: Metric?
    let medium: Metric?
    let standard: Metric?
}

struct Metric: Codable, Hashable {
    var height: Int
    var url: String = ""
    var width: Int
}

struct IdentifiableTVListItem: Identifiable {
    let id: String
    let tvItem: TVListItem
}



