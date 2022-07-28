//
//  ProductRepository.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 28/07/2022.
//

import Foundation

protocol ProductRepository {
    func getCategories(retailer: Int, completion: @escaping ([Category]?, String?)->())
    func getProducts(ofCategory categoryID: Int, retailer: Int, offset: Int, limit: Int, completion: @escaping ([Product]?, String?)->())
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
    
    func getProducts(ofCategory categoryID: Int, retailer: Int, offset: Int, limit: Int, completion: @escaping ([Product]?, String?) -> ()) {
        let endpoint = ProductEndpoint.fetchProducts(categoryID: categoryID, retailerID: retailer, offset: offset, limit: limit)
        
        self.networkClient.request(endpoint: endpoint, type: ProductResponse.self) { response in
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
}
