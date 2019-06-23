//
//  NetworkTask.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import Foundation

protocol NetworkTaskInterface {
    func sendRequest(urlString: String, completion: @escaping (ResponseType) -> Void)
    func sendRequest(urlString: String, params: Dictionary<String, Any>?, httpMethod: HTTPMethod, completion: @escaping (ResponseType) -> Void)
}

enum ResponseError: Error {
    case emptyResponse
    case invalidUrl
}

enum ResponseType {
    case success(data: Data)
    case failure(error:Error?)
}

enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
}

class NetworkTask : NetworkTaskInterface {
    
    func sendRequest(urlString: String, completion: @escaping (ResponseType) -> Void) {
        sendRequest(urlString: urlString, params: nil, httpMethod: .get, completion: completion)
    }
    
    func sendRequest(urlString: String, params: Dictionary<String, Any>?, httpMethod: HTTPMethod, completion: @escaping (ResponseType) -> Void)  {
        do {
            guard  let url = URL(string: urlString) else {
                completion(.failure(error: ResponseError.invalidUrl))
                return
            }
            var request = URLRequest(url: url)
            
            if let params = params {
                let jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                request.httpBody = jsonData
            }
            
            request.httpMethod = httpMethod.rawValue
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            sendRequest(request: request, completion: completion)
        } catch let error {
            completion(.failure(error: error))
        }
    }
    
    //MARK: Private
    private func sendRequest(request: URLRequest, completion: @escaping (ResponseType) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(error: error))
                return
            }
            guard let dataResponse = data else {
                completion(.failure(error: ResponseError.emptyResponse))
                return
            }
            completion(.success(data: dataResponse))
        }
        
        task.resume()
    }
}
