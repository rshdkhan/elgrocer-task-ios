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
            "client_id": "ddTSGprXlCYJhQIIj1wCuvDgNz-ddvcjCjPz3iUrHmc",
            "client_secret": "RCVDiI8HdLjolcIMStyfyu7mQeP23SFaJKJgmy0bXUg",
            "grant_type": "client_credentials",
            "redirect_uri": "https://el-grocer-staging-dev.herokuapp.com"
        ]
        
        return params
    }
    
    var encoding: ParameterEncoder {
        return JsonParamsEncoder()
    }
}
