//
//  Product.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 28/07/2022.
//

import Foundation

struct ProductResponse: Codable {
    let status: String
    let data: [Product]
}

struct Product: Codable {
    let id, retailerID: Int
    let name, slug, description, barcode: String
    let imageURL, fullImageURL: String
    let sizeUnit: String
    let fullPrice: Double
    let priceCurrency: String
    let isAvailable, isPublished, isP: Bool
    let availableQuantity: Int

    enum CodingKeys: String, CodingKey {
        case id
        case retailerID = "retailer_id"
        case name, slug
        case description
        case barcode
        case imageURL = "image_url"
        case fullImageURL = "full_image_url"
        case sizeUnit = "size_unit"
        case fullPrice = "full_price"
        case priceCurrency = "price_currency"
        case isAvailable = "is_available"
        case isPublished = "is_published"
        case isP = "is_p"
        case availableQuantity = "available_quantity"
    }
}
