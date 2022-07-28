//
//  ProductRepository.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 28/07/2022.
//

import Foundation

protocol ProductRepository {
    func getCategories(retailer: Int, completion: @escaping ([Category]?, String?)->())
    func getProducts(ofCategory categoryID: String)
}

class ProductRepositoryImp: ProductRepository {
    var networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getCategories(retailer: Int, completion: @escaping ([Category]?, String?) -> ()) {
        self.networkClient.request(endpoint: ProductEndpoint.fetchCategories(retailerID: 16), type: CategoryResponse.self) { response in
            switch response.status {
                
            case .success:
                completion(response.data?.data, nil)
                break
                
            case .failure:
                completion(nil, "Pass API failure message here ...")
                break
            }
        }
    }
    
    func getProducts(ofCategory categoryID: String) {
        
    }
}


// MARK: - Welcome
struct Welcome: Codable {
    let status: String
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let name, slug, datumDescription, message: String
    let isWeighted: Bool
    let metaData: MetaDataUnion
    let photoURL: String
    let isShowBrand, isFood, pg18: Bool
    let coloredImgURL: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case datumDescription
        case message
        case isWeighted
        case metaData
        case photoURL
        case isShowBrand
        case isFood
        case pg18
        case coloredImgURL
    }
}

enum MetaDataUnion: Codable {
    case metaDataClass(MetaDataClass)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(MetaDataClass.self) {
            self = .metaDataClass(x)
            return
        }
        throw DecodingError.typeMismatch(MetaDataUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for MetaDataUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .metaDataClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - MetaDataClass
struct MetaDataClass: Codable {
    let title: Title
    let keywords: Keywords
    let metaDataDescription: Description

    enum CodingKeys: String, CodingKey {
        case title, keywords
        case metaDataDescription
    }
}

enum Keywords: String, Codable {
    case kyeWordS = "kye,word,s"
}

enum Description: String, Codable {
    case descriptionDescription = "Description"
}

enum Title: String, Codable {
    case pageTitle = "Page Title"
}
