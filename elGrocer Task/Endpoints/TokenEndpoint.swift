//
//  TokenEndpoint.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 28/07/2022.
//

import Foundation


enum TokenEndpoints {
    case refreshToken
}

extension TokenEndpoints: Endpoint {
    var baseUrl: String {
        return "https://el-grocer-staging-dev.herokuapp.com/"
    }
    
    var path: String {
        return "oauth/token"
    }
    
    var method: HttpMethod {
        return .post
    }
    
    var headers: HttpHeaders? {
        return nil
    }
    
    var parameters: Parameters {
        let params: [String: Any] = [
            "client_id": Constatns.clientID,
            "client_secret": Constatns.clientSecret,
            "grant_type": Constatns.grantType,
            "redirect_uri": Constatns.redirectUri
        ]
        
        return params
    }
    
    var encoding: ParameterEncoder {
        return JsonParamsEncoder()
    }
}
