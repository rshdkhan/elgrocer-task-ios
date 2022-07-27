//
//  Endpoint.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 28/07/2022.
//

import Foundation

typealias HttpHeaders = [String: String]
typealias Parameters = [String: Any]

enum HttpMethod: String {
    case get = "get"
    case post = "post"
}

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var headers: HttpHeaders? { get }
    var parameters: Parameters { get }
    var encoding: ParameterEncoder { get }
}
