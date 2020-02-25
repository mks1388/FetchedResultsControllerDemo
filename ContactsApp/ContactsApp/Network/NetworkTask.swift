//
//  NetworkTask.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import Foundation

protocol NetworkTaskInterface {
    func sendRequest(request: NetworkRequestProtocol, completion: @escaping (Result<Data, Error>) -> Void)
}

struct NetworkTask : NetworkTaskInterface {
    func sendRequest(request: NetworkRequestProtocol, completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            guard  let url = URL(string: request.requestUrlString) else {
                completion(.failure(ResponseError.invalidUrl))
                return
            }
            
            var urlRequest = URLRequest(url: url)
            
            if let params = request.body {
                let jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                urlRequest.httpBody = jsonData
            }
            
            urlRequest.httpMethod = request.httpMethod.rawValue
            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            sendRequest(request: urlRequest, completion: completion)
        } catch let error {
            completion(.failure(error))
        }
    }
}

// MARK: - Private
extension NetworkTask {
    func sendRequest(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let dataResponse = data else {
                completion(.failure(ResponseError.emptyResponse))
                return
            }
            completion(.success(dataResponse))
        }
        
        task.resume()
    }
}
