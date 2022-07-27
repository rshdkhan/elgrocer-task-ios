//
//  Response.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 28/07/2022.
//

import Foundation

enum ResponseStatus {
    case success
    case failure
}

enum NetworkError {
    case tokenExpires
    case other
}

struct NetworkResponse<T> {
    var status: ResponseStatus
    var error: NetworkError?
    var data: T?
    
    init(data: T) {
        self.status = .success
        self.data = data
    }
    
    init(error: NetworkError) {
        self.status = .failure
        self.error = error
    }
}


