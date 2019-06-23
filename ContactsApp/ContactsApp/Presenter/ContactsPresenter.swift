//
//  ContactsPresenter.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit

protocol TableViewPresenterInterface {
    func numberOfSections() -> Int
    func numberOfRows(inSection section:Int) -> Int
    func titleForHeader(inSection section: Int) -> String?
    func heightForRow(atIndexPath indexPath : IndexPath) -> CGFloat
    
    func didSelectRow(atIndexpath indexPath: IndexPath, viewController:UIViewController)
}

extension TableViewPresenterInterface {
    func didSelectRow(atIndexpath indexPath: IndexPath, viewController:UIViewController) {}
    
    func titleForHeader(inSection section: Int) -> String? { return nil }
}

protocol ContactsPresenterInterface: TableViewPresenterInterface {
    
    var delegate : ContactsPresenterDelegate? {get set}
    
    func startFetchingContacts()
    
    func sectionIndexTitles() -> [String]?
    
    func itemForRow(atIndexpath indexPath:IndexPath) -> ContactModel?
    
    func didClickAddContact(fromViewController viewController : UIViewController)
    
    func showAlert(title: String, message: String, from: UIViewController)
}

protocol ContactsPresenterDelegate : class {
    func reloadTable()
    func showError(error: Error?)
}


class ContactsPresenter {
    weak var delegate: ContactsPresenterDelegate?

    private var arrContact = [ContactModel]()
    private var datasourceArray = [ContactsSectionModel]()
    private let contactsInteractor : ContactsInteractorInterface

    init(interactor : ContactsInteractorInterface) {
        contactsInteractor = interactor
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(notification:)), name: NSNotification.Name.contactUpdated, object: nil)
    }
    
    //MARK: Private
    @objc private func handleNotification(notification: Notification) {
        guard notification.name == Notification.Name.contactUpdated else {
            return
        }
        if let contact = notification.object as? ContactModel {
            datasourceArray = AppUtils.update(array: arrContact, with: contact)
            delegate?.reloadTable()
        }
    }
}

//MARK: Contacts Presenter Interface
extension ContactsPresenter: ContactsPresenterInterface {
    func showAlert(title: String, message: String, from: UIViewController) {
        AppRouter.shared.showAlert(title: title, message: message, from: from)
    }
    
    func heightForRow(atIndexPath indexPath : IndexPath) -> CGFloat {
        return CGFloat(Constants.UI.contactCellDefaultHeight)
    }
    
    func didClickAddContact(fromViewController viewController : UIViewController) {
        AppRouter.shared.presentAddContactVC(from: viewController)
    }
    
    func didSelectRow(atIndexpath indexPath: IndexPath, viewController: UIViewController) {
        guard let navVC = viewController.navigationController else {
            return
        }
        if indexPath.section < datasourceArray.count {
            let sectionModel = datasourceArray[indexPath.section]
            let contactModel = sectionModel.contacts[indexPath.row]
            AppRouter.shared.pushContactDetailVC(selectedContact: contactModel, from: navVC)
        }
        
    }
    
    func startFetchingContacts() {
        contactsInteractor.fetchContacts { [weak self] (result) in
            switch result {
            case .success(let data):
                do {
                    let arrContact = try JSONDecoder().decode([ContactModel].self, from: data)
                    self?.arrContact = arrContact
                    self?.datasourceArray = AppUtils.mapContactsIntoSections(arrContact: arrContact)
                    self?.delegate?.reloadTable()
                } catch let error {
                    self?.delegate?.showError(error: error)
                }
            case .failure(let error):
                self?.delegate?.showError(error: error)
            }
        }
    }
    
    func numberOfRows(inSection section:Int) -> Int {
        if section < datasourceArray.count {
            return datasourceArray[section].contacts.count
        }
        return 0
    }
    
    func numberOfSections() -> Int {
        return datasourceArray.count
    }
    
    func sectionIndexTitles() -> [String]? {
        return datasourceArray.map{$0.title}
    }
    
    func titleForHeader(inSection section: Int) -> String? {
        var title = Constants.emptyString
        if section < datasourceArray.count {
            title = datasourceArray[section].title
        }
        return title
    }
    
    func itemForRow(atIndexpath indexPath: IndexPath) -> ContactModel? {
        var contactModel : ContactModel?
        if indexPath.section < datasourceArray.count {
            let sectionModel = datasourceArray[indexPath.section]
            contactModel = sectionModel.contacts[indexPath.row]
        }
        return contactModel
    }
}
