//
//  AddContactTableViewController.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit

class AddContactTableViewController: ContactTableViewController {
    weak var headerView: AddContactTableViewHeader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if var presenter = presenter as? AddContactPresenterInterface {
            presenter.imagePickerDelegate = self
        }
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: AddContactTableViewHeader.reuseIdentifier) as? AddContactTableViewHeader else {
            return nil
        }
        headerCell.updateProfilePic(url: presenter.contact?.getProfilePicUrl())
        headerCell.delegate = self
        
        headerView = headerCell
        
        return headerCell
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        guard let presenter = presenter as? AddContactPresenterInterface else {
            return
        }
        presenter.didClickCancel(viewController: self)
    }
    
    @IBAction func doneButtonClicked(_ sender: UIBarButtonItem) {
        guard let presenter = presenter as? AddContactPresenterInterface else {
            return
        }
        var dict = [String: Any]()
        let rows = presenter.numberOfRows(inSection: 0)
        for row in 0..<rows {
            let indexPath = IndexPath(row: row, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? LabelTextFieldTableViewCell, let model = presenter.itemForRow(atIndexpath: indexPath) {
                dict[model.title.getJSONKey()] = cell.textView.text
            }
        }
        let (valid, validationErrorMessage) = presenter.checkIfValidData(params: dict)
        if !valid {
            presenter.showAlert(title: Constants.ErrorMessage.validationTitle, message: validationErrorMessage ?? Constants.emptyString, from: self)
            return
        }
        ActivityIndicator.shared.show()
        presenter.didClickDone(contact: dict, viewController: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(Constants.UI.addContactHeaderHeight)
    }
}

//MARK: Add Contact Table View Header Delegate
extension AddContactTableViewController: AddContactTableViewHeaderDelegate {
    func didClickCameraButton() {
        if let presenter = presenter as? AddContactPresenterInterface {
            presenter.showAlertToSelectImageSource(from: self)
        }
    }
}

//MARK:
extension AddContactTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        headerView?.updateProfilePic(image: selectedImage)
        picker.dismiss(animated: true, completion: nil)
    }
}
