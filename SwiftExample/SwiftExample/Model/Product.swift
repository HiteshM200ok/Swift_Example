//
//  Product.swift
//  SwiftExample
//
//  Created by 200OK-IOS5 on 21/02/24.
//

import Foundation

struct Products: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category, thumbnail: String
    let images: [String]
}
