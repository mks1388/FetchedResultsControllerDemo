
//
//  ContactsInteractor.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit

protocol ContactsInteractorInterface {
    func fetchContacts(completion: @escaping (Result<Data, Error>) -> Void)
    func fetchContactDetail(id: String, completion: @escaping (Result<Data, Error>) -> Void)
    func addContact(params: Dictionary<String, Any>, completion: @escaping (Result<Data, Error>) -> Void)
    func updateContact(id: String, params: Dictionary<String, Any>, completion: @escaping (Result<Data, Error>) -> Void)
}

struct ContactsInteractor: ContactsInteractorInterface {
    
    private let networkTask : NetworkTaskInterface
    
    init(networkTask : NetworkTaskInterface) {
        self.networkTask = networkTask
    }
    
    func fetchContacts(completion: @escaping (Result<Data, Error>) -> Void) {
        let request = GetRequest(queryParams: nil, urlString: Constants.APIUrl.contactsUrl)
        networkTask.sendRequest(request: request, completion: completion)
    }
    
    func fetchContactDetail(id: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let request = GetRequest(queryParams: nil, urlString: Constants.APIUrl.contactDetailBaseUrl + "/\(id).json")
        networkTask.sendRequest(request: request, completion: completion)
    }
    
    func addContact(params: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        let request = PostRequest(requestUrlString: Constants.APIUrl.contactsUrl, body: params)
        networkTask.sendRequest(request: request, completion: completion)
    }
    
    func updateContact(id: String, params: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        let request = PutRequest(requestUrlString: Constants.APIUrl.contactDetailBaseUrl + "/\(id).json", body: params)
        networkTask.sendRequest(request: request, completion: completion)
    }
}
