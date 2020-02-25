//
//  PostRequest.swift
//  ContactsApp
//
//  Created by Mithilesh on 25/02/20.
//  Copyright © 2020 Mithilesh Kumar Singh. All rights reserved.
//

import Foundation

struct PostRequest: NetworkRequestProtocol {
    let requestUrlString: String
    let body: [String: Any]?
    
    var httpMethod: HTTPMethod {
        return .post
    }
}
