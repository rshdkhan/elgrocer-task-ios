//
//  NetworkClient.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 28/07/2022.
//

import Foundation

typealias requestCompletion<T> = (NetworkResponse<T>) ->()

protocol NetworkClient {
    func request<T>(endpoint: Endpoint, type: T.Type, completion: @escaping requestCompletion<T>) where T: Codable
}

extension NetworkClient {
    func urlRequest(endpoint: Endpoint) throws -> URLRequest {
        let baseUrl = URL(string: endpoint.baseUrl)!
        
        var request = URLRequest(url: baseUrl.appendingPathComponent(endpoint.path))
        request.httpMethod = endpoint.method.rawValue
        
        if endpoint.headers != nil {
            request.allHTTPHeaderFields = endpoint.headers
        }
        
        do {
            try endpoint.encoding.encode(urlRequest: &request, with: endpoint.parameters)
        } catch {
            throw error
        }
        
        return request
    }
}

class NetworkClientImp: NetworkClient {
    var urlSession: URLSession
    var responseHandler: ResponseHandler
    
    init(urlSession: URLSession, responseHandler: ResponseHandler) {
        self.urlSession = urlSession
        self.responseHandler = responseHandler
    }
    
    func request<T>(endpoint: Endpoint, type: T.Type, completion: @escaping requestCompletion<T>) where T: Codable {
        do {
            let request = try self.urlRequest(endpoint: endpoint)
            
            let task = urlSession.dataTask(with: request) { data, response, error in
                let response = self.responseHandler.handle(to: type, data: data, response: response, error: error)
                completion(response)
            }
            
            task.resume()
        } catch {
            
        }
    }
}
