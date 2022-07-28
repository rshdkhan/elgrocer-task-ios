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


//{
//            "id": 6307,
//            "retailer_id": 16,
//            "name": "Emirates Macaroni Sedano Full",
//            "slug": "emirates-macaroni-sedano-full",
//            "description": "",
//            "barcode": "6291047020517",
//            "image_url": "https://s3-eu-west-1.amazonaws.com/elgrocertest/products/photos/000/006/307/medium/1.png?1448792898",
//            "full_image_url": "https://s3-eu-west-1.amazonaws.com/elgrocertest/products/photos/000/006/307/medium/1.png?1448792898",
//            "size_unit": "400g",
//            "full_price": 150.0,
//            "price_currency": "AED",
//            "promotion": {
//                "price": 150.0,
//                "price_currency": "AED",
//                "start_time": 1627794000000.0,
//                "end_time": 1662055200000.0,
//                "product_limit": 3
//            },
//            "brand": {
//                "id": 669,
//                "name": "Emirates Macaroni",
//                "slug": "emirates-macaroni"
//            },
//            "categories": [
//                {
//                    "id": 94,
//                    "name": "Pasta & Rice",
//                    "slug": "pasta-rice",
//                    "is_food": true,
//                    "pg_18": false
//                }
//            ],
//            "subcategories": [
//                {
//                    "id": 154,
//                    "name": "Pasta",
//                    "slug": "pasta",
//                    "is_food": false,
//                    "pg_18": false
//                }
//            ],
//            "is_available": true,
//            "is_published": true,
//            "is_p": true,
//            "available_quantity": -1
//        }

struct Product: Codable {
    let id, retailerID: Int
    let name, slug, description, barcode: String
    let imageURL, fullImageURL: String
    let sizeUnit: String
    let fullPrice: Double
    let priceCurrency: String
//    let promotion: Promotion
//    let brand: Brand
//    let categories, subcategories: [Category]
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
//        case promotion, brand, categories, subcategories
        case isAvailable = "is_available"
        case isPublished = "is_published"
        case isP = "is_p"
        case availableQuantity = "available_quantity"
    }
}
