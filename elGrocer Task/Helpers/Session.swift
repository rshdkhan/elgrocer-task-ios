//
//  Session.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 28/07/2022.
//

import Foundation

class Session {
    static let instance = Session()
    
    private init() {
    }
    
    func create(tokenResponse: RefreshTokenResponse) {
        UserDefaults.standard.set(tokenResponse.accessToken, forKey: "access.token")
        UserDefaults.standard.set(tokenResponse.expiresIn, forKey: ".expires.in")
    }
    
    var token: String {
        return UserDefaults.standard.string(forKey: "access.token") ?? ""
    }
}
