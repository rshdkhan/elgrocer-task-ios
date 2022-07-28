//
//  Category.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 28/07/2022.
//

import Foundation

struct CategoryResponse: Codable {
    let status: String
    let data: [Category]
}

struct Category: Codable {
    let id: Int
    let name: String
    let slug: String
    let description: String
    let message: String
    let isWeighted: Bool
    let photoUrl: String
    let isShowBrand: Bool
    let isFood: Bool
    let pg18: Bool
    let coloredImageUrl: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug, description, message
        case isWeighted = "is_weighted"
        case photoUrl = "photo_url"
        case isShowBrand = "is_show_brand"
        case isFood = "is_food"
        case pg18 = "pg_18"
        case coloredImageUrl = "colored_img_url"
    }
}
