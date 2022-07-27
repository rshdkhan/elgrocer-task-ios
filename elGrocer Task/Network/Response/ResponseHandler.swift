//
//  ResponseHandler.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 28/07/2022.
//

import Foundation

private enum ResponseStatusCode {
    static let success = 200...399
    static let requestError = 400...499
    static let serverError = 500...599
}

protocol ResponseHandler {
    func handle<T: Codable>(to type: T.Type, data: Data?, response: URLResponse?, error: Error?) -> NetworkResponse<T>
}

class ResponseHandlerImp: ResponseHandler {
    func handle<T: Codable>(to type: T.Type, data: Data?, response: URLResponse?, error: Error?) -> NetworkResponse<T> {
        guard let response = response as? HTTPURLResponse else {
            return NetworkResponse(error: .other)
        }
        
        switch response.statusCode {
        case ResponseStatusCode.success:
            if let data = data {
                do {
                    let item = try JSONDecoder().decode(type, from: data)
                    return NetworkResponse(data: item)
                } catch {
                    return NetworkResponse(error: .other)
                }
            }
            
        case ResponseStatusCode.requestError:
            break
            
        case ResponseStatusCode.serverError:
            return NetworkResponse(error: .other)
            
        default:
            break
        }
        
        return NetworkResponse(error: .other)
    }
}
