//
//  AccessToken.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 28/07/2022.
//

import Foundation

struct RefreshTokenResponse: Codable {
    
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let scope: String
    let createdAt: Int64
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope = "scope"
        case createdAt = "created_at"
    }
}
