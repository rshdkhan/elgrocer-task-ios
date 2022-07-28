//
//  ProductEndpoint.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 28/07/2022.
//

import Foundation

enum ProductEndpoint {
    case fetchCategories(retailerID: Int)
    case fetchProducts
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
            "access_token": "uR0ZIzfv2IwDy0jiw-rfV_JR3XZJvZ0_0ppuVmGbGFg",
            "Locale": "en"
        ]
    }
    
    var parameters: Parameters {
        switch self {
            case .fetchCategories(let retailerID):
                return ["retailer_id": retailerID, "delivery_time": Date().millisecondsSince1970]
            case .fetchProducts:
                return [:]
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
