
//
//  ContactsInteractor.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit

protocol ContactsInteractorInterface : class {
    
    func fetchContacts(completion: @escaping (ResponseType) -> Void)
    func fetchContactDetail(id: String, completion: @escaping (ResponseType) -> Void)
    func addContact(params: Dictionary<String, Any>, completion: @escaping (ResponseType) -> Void)
    func updateContact(id: String, params: Dictionary<String, Any>, completion: @escaping (ResponseType) -> Void)
}

class ContactsInteractor: ContactsInteractorInterface {
    
    private let networkTask : NetworkTaskInterface
    
    init(networkTask : NetworkTaskInterface) {
        self.networkTask = networkTask
    }
    
    func fetchContacts(completion: @escaping (ResponseType) -> Void) {
        networkTask.sendRequest(urlString: Constants.APIUrl.contactsUrl, completion: completion)
    }
    
    func fetchContactDetail(id: String, completion: @escaping (ResponseType) -> Void) {
        networkTask.sendRequest(urlString: Constants.APIUrl.contactDetailBaseUrl + "/\(id).json", completion: completion)
    }
    
    func addContact(params: Dictionary<String, Any>, completion: @escaping (ResponseType) -> Void) {
        networkTask.sendRequest(urlString: Constants.APIUrl.contactsUrl, params: params, httpMethod: .post, completion: completion)
    }
    
    func updateContact(id: String, params: Dictionary<String, Any>, completion: @escaping (ResponseType) -> Void) {
        networkTask.sendRequest(urlString: Constants.APIUrl.contactDetailBaseUrl + "/\(id).json", params: params, httpMethod: .put, completion: completion)
    }
}
