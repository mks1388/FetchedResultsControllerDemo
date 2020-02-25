//
//  GetRequest.swift
//  ContactsApp
//
//  Created by Mithilesh on 25/02/20.
//  Copyright © 2020 Mithilesh Kumar Singh. All rights reserved.
//

import Foundation

struct GetRequest: NetworkRequestProtocol {
    let queryParams: [String : Any]?
    let urlString: String
    
    var requestUrlString: String {
        guard let params = queryParams else {
            return urlString
        }
        var paramString = ""
        for (key, value) in params {
            if paramString.isEmpty {
                paramString += "\(key)=\(value)"
            } else {
                paramString += "&\(key)=\(value)"
            }
        }
        return urlString + "?\(paramString)"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
}
