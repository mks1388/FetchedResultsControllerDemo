//
//  ContactsTableViewController.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController, ReusableInterface {

    var presenter: ContactsPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ActivityIndicator.shared.show()
        presenter.startFetchingContacts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = Constants.UI.contactListTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContactClicked(_:)))
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(inSection: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.reuseIdentifier, for: indexPath)

        guard let contactCell = cell as? ContactTableViewCell else {
            return cell
        }
        
        if let contactModel = presenter.itemForRow(atIndexpath: indexPath) {
          contactCell.updateCell(contact: contactModel)
        }

        return contactCell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.titleForHeader(inSection: section)
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(atIndexpath: indexPath, viewController: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter.heightForRow(atIndexPath: indexPath)
    }
    
    //MARK: Private
    @objc private func addContactClicked(_ sender: UIBarButtonItem) {
        presenter.didClickAddContact(fromViewController: self)
    }
}

extension ContactsTableViewController: ContactsPresenterDelegate {
    func reloadTable() {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                self.reloadTable()
            }
            return
        }
        ActivityIndicator.shared.hide()
        tableView.reloadData()
    }
    
    func showError(error: Error?) {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                self.showError(error: error)
            }
            return
        }
        ActivityIndicator.shared.hide()
        
        let message = error?.localizedDescription ?? Constants.ErrorMessage.defaultMessage
        presenter.showAlert(title: Constants.ErrorMessage.defaultTitle, message: message, from: self)
    }
}
