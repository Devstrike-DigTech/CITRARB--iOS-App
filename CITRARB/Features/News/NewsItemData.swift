//
//  NewsItemData.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import Foundation

struct News: Hashable, Codable{
    
    let author: String
    let category: String
    let cover_photo_big_size: String
    let cover_photo_small_size: String
    let date: String
    let description: String
    let id: Int
    let link: String
    let title: String
    
}
