//
//  AppBuilder.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit

class AppBuilder {
    static let shared = AppBuilder()
    
    private init() {}
    
    func getAddContactVC(selectedcontact contact:ContactModel?) -> UINavigationController? {
        let storyboard = UIStoryboard(name: Constants.StoryboardName.main, bundle: Bundle.main)
        
        guard let contactVC = storyboard.instantiateViewController(withIdentifier: AddContactTableViewController.reuseIdentifier) as? AddContactTableViewController else {
            return nil
        }
        
        let networkTask = NetworkTask()
        let interactor = ContactsInteractor(networkTask: networkTask)
        
        let presenter = AddContactPresenter(contact: contact, interactor: interactor)
        presenter.delegate = contactVC
        
        contactVC.presenter = presenter
        
        let navVC = UINavigationController(rootViewController: contactVC)
        
        return navVC
    }
    
    func getViewContactVC(selectedcontact contact:ContactModel?) -> UIViewController? {
        let storyboard = UIStoryboard(name: Constants.StoryboardName.main, bundle: Bundle.main)
        
        guard let contactVC = storyboard.instantiateViewController(withIdentifier: ContactDetailTableViewController.reuseIdentifier) as? ContactDetailTableViewController else {
            return nil
        }
        
        let networkTask = NetworkTask()
        let interactor = ContactsInteractor(networkTask: networkTask)
        
        let presenter = ViewContactPresenter(contact: contact, interactor: interactor)
        presenter.delegate = contactVC
        
        contactVC.presenter = presenter
        return contactVC
    }
    
    func getAlert(title: String?, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.UI.ok, style: .cancel, handler: nil)
        alert.addAction(action)
        
        return alert
    }
}
