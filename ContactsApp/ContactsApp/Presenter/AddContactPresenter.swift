//
//  AddContactPresenter.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 23/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit

protocol AddContactPresenterInterface: ContactDetailPresenterInterface {
    func didClickCancel(viewController: UIViewController)
    func didClickDone(contact: [String: Any], viewController: UIViewController)
    
    func checkIfValidData(params: [String: Any]) -> (Bool, String?)
    
    var imagePickerDelegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)? { get set }
    
    func showAlertToSelectImageSource(from viewController: UIViewController)
}

class AddContactPresenter: ContactDetailPresenter, AddContactPresenterInterface {
    var imagePickerDelegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?
    
    func checkIfValidData(params: [String : Any]) -> (Bool, String?) {
        guard let firstName = params[LabelTextFieldViewModelTitle.firstName.getJSONKey()] as? String, !firstName.isEmpty else {
            return (false, Constants.ErrorMessage.invalidFirstName)
        }
        guard let lastName = params[LabelTextFieldViewModelTitle.lastName.getJSONKey()] as? String, !lastName.isEmpty else {
            return (false, Constants.ErrorMessage.invalidLastName)
        }
        guard let mobile = params[LabelTextFieldViewModelTitle.mobile.getJSONKey()] as? String, mobile.isValidMobile() else {
            return (false, Constants.ErrorMessage.invalidMobile)
        }
        guard let email = params[LabelTextFieldViewModelTitle.email.getJSONKey()] as? String, email.isValidEmail() else {
            return (false, Constants.ErrorMessage.invalidEmail)
        }
        return (true, nil)
    }
    
    
    override var contact: ContactModel? {
        didSet {
            prepareArrViewModel()
        }
    }
    
    func didClickCancel(viewController: UIViewController) {
        AppRouter.shared.dismissVC(viewController: viewController)
    }
    
    func didClickDone(contact: [String: Any], viewController: UIViewController) {
        if let id = self.contact?.id {
            contactsInteractor.updateContact(id: "\(id)", params: contact) {[weak self] (responseType) in
                self?.handleResponse(responseType: responseType)
                AppRouter.shared.dismissVC(viewController: viewController)
            }
        } else {
            contactsInteractor.addContact(params: contact) {[weak self] (responseType) in
                self?.handleResponse(responseType: responseType)
                AppRouter.shared.dismissVC(viewController: viewController)
            }
        }
    }
    
    //MARK: private
    private func prepareArrViewModel() {
        let arr = [LabelTextFieldViewModelTitle.firstName, LabelTextFieldViewModelTitle.lastName, LabelTextFieldViewModelTitle.mobile, LabelTextFieldViewModelTitle.email]
        arrViewModel = AppModelMapper.mapContactToLabelTextFieldViewModelArr(contact: contact, arrVMTitle: arr, editable: true)
    }
}

//MARK: Image Picker
extension AddContactPresenter {
    func showAlertToSelectImageSource(from viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: Constants.PicOptions.camera, style: .default) { [weak self] (action) in
                self?.openImageSource(source: .camera, from: viewController)
            }
            alert.addAction(cameraAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let libraryAction = UIAlertAction(title: Constants.PicOptions.library, style: .default) { [weak self] (action) in
                self?.openImageSource(source: .photoLibrary, from: viewController)
            }
            alert.addAction(libraryAction)
        }
        
        if alert.actions.count > 0 {
            let cancelAction = UIAlertAction(title: Constants.PicOptions.cancel, style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            AppRouter.shared.present(alert, from: viewController)
        }
    }
    
    private func openImageSource(source: UIImagePickerController.SourceType, from viewController: UIViewController) {
        let picker = UIImagePickerController()
        picker.delegate = imagePickerDelegate
        picker.sourceType = source
        AppRouter.shared.present(picker, from: viewController)
    }
}
