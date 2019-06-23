//
//  AddContactPresenterInterface.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit

protocol ContactDetailPresenterInterface: TableViewPresenterInterface {
    var delegate : ContactDetailPresenterDelegate? { get set }
    var contact: ContactModel? { get }
    
    func itemForRow(atIndexpath indexPath:IndexPath) -> LabelTextFieldViewModel?
    func itemForHeader() -> ContactModel?
    
    func fetchDetail()
    func toggleFavourite()
    
    func showAlert(title: String, message: String, from: UIViewController)
}

protocol ContactDetailPresenterDelegate: class {
    func contactUpdated()
}

enum AddContactPresenterType {
    case detail
    case add
}

class ContactDetailPresenter: ContactDetailPresenterInterface {
    var arrViewModel = [LabelTextFieldViewModel]()
    var contact: ContactModel?
    let contactsInteractor : ContactsInteractorInterface
    weak var delegate: ContactDetailPresenterDelegate?
    
    init(contact: ContactModel?, interactor: ContactsInteractorInterface) {
        self.contactsInteractor = interactor
        defer {
            self.contact = contact
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(notification:)), name: NSNotification.Name.contactUpdated, object: nil)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return arrViewModel.count
    }
    
    func heightForRow(atIndexPath indexPath: IndexPath) -> CGFloat {
        return CGFloat(Constants.UI.labelTaxtCellDefaultHeight)
    }
    
    func itemForRow(atIndexpath indexPath: IndexPath) -> LabelTextFieldViewModel? {
        var viewModel : LabelTextFieldViewModel?
        if indexPath.row < arrViewModel.count {
            viewModel = arrViewModel[indexPath.row]
        }
        return viewModel
    }
    
    func itemForHeader() -> ContactModel? {
        return contact
    }
    
    func fetchDetail() {
        guard let contact = contact else {
            return
        }
        contactsInteractor.fetchContactDetail(id: "\(contact.id)") {[weak self] (responseType) in
            self?.handleResponse(responseType: responseType)
        }
    }
    
    func toggleFavourite() {
        guard var contact = contact else {
            return
        }
        contact.favorite = !contact.favorite
        updateDetail(contact: contact)
    }
    
    func handleResponse(responseType: ResponseType) {
        switch responseType {
        case .success(data: let data):
            do {
                let model = try JSONDecoder().decode(ContactModel.self, from: data)
                contact = model
                NotificationCenter.default.post(name: NSNotification.Name.contactUpdated, object: contact)
            } catch let error {
                print("Error while parsing data \(error.localizedDescription)")
            }
        case .failure(error: let error):
            print("Error while fetching detail \(error?.localizedDescription ?? Constants.emptyString)")
        }
    }
    
    func showAlert(title: String, message: String, from: UIViewController) {
        AppRouter.shared.showAlert(title: title, message: message, from: from)
    }
    
    //MARK: Private
    private func updateDetail(contact: ContactModel) {
        guard let dict = contact.dictionary else {
            return
        }
        
        contactsInteractor.updateContact(id: "\(contact.id)", params: dict) {[weak self] (responseType) in
            self?.handleResponse(responseType: responseType)
        }
    }
}

//MARK: Notification
extension ContactDetailPresenter {
    
    @objc private func handleNotification(notification: Notification) {
        guard notification.name == Notification.Name.contactUpdated else {
            return
        }
        if let contact = notification.object as? ContactModel {
            self.contact = contact
            delegate?.contactUpdated()
        }
    }
}
