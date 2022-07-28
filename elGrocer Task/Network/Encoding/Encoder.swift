//
//  Encoder.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 28/07/2022.
//

import Foundation

protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
