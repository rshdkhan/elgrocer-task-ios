//
//  TokenRepository.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 28/07/2022.
//

import Foundation

protocol TokenRepository {
    func refreshToken(completion: @escaping (RefreshTokenResponse?, String?)->())
}

class TokenRepositoryImp: TokenRepository {
    private var networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    
    func refreshToken(completion: @escaping (RefreshTokenResponse?, String?) -> ()) {
        self.networkClient.request(endpoint: TokenEndpoints.refreshToken, type: RefreshTokenResponse.self) { response in
            switch response.status {
                
            case .success:
                completion(response.data, nil)
                break
                
            case .failure:
                completion(nil, "Pass API failure message here ...")
                break
            }
        }
    }
}
