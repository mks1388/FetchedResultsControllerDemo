//
//  ContactTableViewController.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 23/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit

protocol ContactTableViewControllerInterface {
    var presenter: ContactDetailPresenterInterface! { get set }
}

class ContactTableViewController: UITableViewController, ContactTableViewControllerInterface, ReusableInterface {
    
    var presenter: ContactDetailPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: LabelTextFieldTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: LabelTextFieldTableViewCell.reuseIdentifier)
        
        presenter.fetchDetail()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(inSection: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LabelTextFieldTableViewCell.reuseIdentifier, for: indexPath)
        
        guard let labelTextCell = cell as? LabelTextFieldTableViewCell, let model = presenter.itemForRow(atIndexpath: indexPath) else {
            return cell
        }
        
        labelTextCell.updateCell(model: model)
        
        return labelTextCell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter.heightForRow(atIndexPath: indexPath)
    }
}

//MARK: Contact Detail Presenter Delegate
extension ContactTableViewController: ContactDetailPresenterDelegate {
    func contactUpdated() {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                self.contactUpdated()
            }
            return
        }
        tableView.reloadData()
        ActivityIndicator.shared.hide()
    }
}
