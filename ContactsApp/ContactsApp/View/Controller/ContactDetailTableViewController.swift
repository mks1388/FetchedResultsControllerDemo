//
//  ContactDetailTableViewController.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 23/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit
import MessageUI

class ContactDetailTableViewController: ContactTableViewController {
    
    @IBAction func editButtonClicked(_ sender: UIBarButtonItem) {
        guard let presenter = presenter as? ViewContactPresenterInterface else {
            return
        }
        presenter.didClickEdit(from: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if var presenter = presenter as? ViewContactPresenterInterface {
            presenter.messageComposeDelegate = self
            presenter.mailComposeDelegate = self
        }
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: ContactDetailTableViewHeader.reuseIdentifier) as? ContactDetailTableViewHeader else {
            return nil
        }
        headerCell.updateDetail(contact: presenter.contact)
        headerCell.delegate = self
        
        return headerCell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(Constants.UI.ContactDetailHeaderHeight)
    }
}

//MARK: Contact Detail Table View Header Delegate
extension ContactDetailTableViewController: ContactDetailTableViewHeaderDelegate {
    func didClickFav() {
        ActivityIndicator.shared.show()
        presenter.toggleFavourite()
    }
    
    func didClickEmail() {
        if let presenter = presenter as? ViewContactPresenterInterface {
            presenter.sendEmailIfAvailable(from: self)
        }
    }
    
    func didClickMessage() {
        if let presenter = presenter as? ViewContactPresenterInterface {
            presenter.sendMessageIfAvailable(from: self)
        }
    }
    
    func didClickCall() {
        if let presenter = presenter as? ViewContactPresenterInterface {
            presenter.callNumber()
        }
    }
}

//MARK: MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate
extension ContactDetailTableViewController: MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        AppRouter.shared.dismissVC(viewController: controller)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        AppRouter.shared.dismissVC(viewController: controller)
    }
}
