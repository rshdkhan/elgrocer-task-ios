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
        UserDefaults.standard.set(tokenResponse.expiresIn, forKey: "expires.in")
        UserDefaults.standard.set(Date(), forKey: "created.at")
    }
    
    var token: String {
        return UserDefaults.standard.string(forKey: "access.token") ?? ""
    }
    
    private var expiresIn: Int {
        return UserDefaults.standard.integer(forKey: "expires.in")
    }
    
    private var createdAt: Date? {
        return UserDefaults.standard.object(forKey: "created.at") as? Date
    }
    
    // check wheather token is valid or not.
    var isValid: Bool {
        guard let expiryDate = createdAt?.addingTimeInterval(TimeInterval(expiresIn)) else {
            return false
        }
    
        let result = Date().compare(expiryDate)
        switch result {
        case .orderedAscending:
            return true

        case .orderedSame:
            return false

        case .orderedDescending:
            return false
        }
    }
}
