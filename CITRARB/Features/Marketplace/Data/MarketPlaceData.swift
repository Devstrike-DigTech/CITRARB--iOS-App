//
//  MarketPlaceData.swift
//  CITRARB
//
//  Created by Richard Uzor on 07/09/2023.
//

import Foundation

struct GetAllProductsResponse: Hashable, Codable{
    let status: String
    let length: Int
    let data: [Product]
}

struct Product: Hashable, Codable{
    let _id: String
    let price: Int
    let name: String
    let category: String
    let images: [String]
    let description: String
    let active: Bool
    let userId: ProductUser
}

struct ProductUser: Hashable, Codable{
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


struct IdentifiableProductListItem: Identifiable {
    let id: String
    let productItem: Product
}

struct CreateProductResponse: Codable{
    let status: String
    let data: ProductResponse
}

struct ProductResponse: Codable{
    let price: Int
    let name: String
    let category: String
    let images: [String]
    let description: String
    let active: Bool
    let userId: String
    let _id: String
    let __v: Int
}

