//
//  ProductEndpoint.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 28/07/2022.
//

import Foundation

enum ProductEndpoint {
    case fetchCategories(retailerID: Int)
    case fetchProducts(categoryID: Int, retailerID: Int, offset: Int, limit: Int)
}

extension ProductEndpoint: Endpoint {
    var baseUrl: String {
        switch self {
            case .fetchCategories   :   return "https://el-grocer-staging-dev.herokuapp.com/api/v1/"
            case .fetchProducts     :   return "https://el-grocer-staging-dev.herokuapp.com/api/v2/"
        }
    }
    
    var path: String {
        switch self {
            case .fetchCategories   :   return "categories/list"
            case .fetchProducts     :   return "products/list"
        }
    }
    
    var method: HttpMethod {
        return .get
    }
    
    var headers: HttpHeaders? {
        return [
            "access_token": "XPT_qbKaH32jFK8ffo9X2fO9hI5aw6DapI6f5q2j-hQ",
            "Locale": "en"
        ]
    }
    
    var parameters: Parameters {
        switch self {
            case .fetchCategories(let retailerID):
                return ["retailer_id": retailerID, "delivery_time": Date().millisecondsSince1970]
        case .fetchProducts(let categoryID, let retailerID, let offset, let limit):
                return [
                    "category_id": categoryID,
                    "retailer_id": retailerID,
                    "delivery_time": Date().millisecondsSince1970,
                    "offset": offset,
                    "limit": limit
                ]
        }
    }
    
    var encoding: ParameterEncoder {
        return UrlParamsEncoder()
    }
}

extension Date {
    var millisecondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
