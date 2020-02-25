//
//  NetworkRequest.swift
//  ContactsApp
//
//  Created by Mithilesh on 25/02/20.
//  Copyright © 2020 Mithilesh Kumar Singh. All rights reserved.
//

import Foundation

enum ResponseError: Error {
    case emptyResponse
    case invalidUrl
}

enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
}

protocol NetworkRequestProtocol {
    var requestUrlString: String { get }
    var body: [String: Any]? { get }
    var httpMethod: HTTPMethod { get }
}

extension NetworkRequestProtocol {
    var body:[String: Any]? {
        return nil
    }
}
