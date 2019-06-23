//
//  ViewContactDetailPresenter.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 23/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit
import MessageUI

protocol ViewContactPresenterInterface: ContactDetailPresenterInterface {
    var mailComposeDelegate: MFMailComposeViewControllerDelegate? { get set }
    var messageComposeDelegate: MFMessageComposeViewControllerDelegate? { get set }
    
    func didClickEdit(from viewController: UIViewController)
    
    func callNumber()
    func sendEmailIfAvailable(from viewController: UIViewController)
    func sendMessageIfAvailable(from viewController: UIViewController)
}

class ViewContactPresenter: ContactDetailPresenter, ViewContactPresenterInterface {
    var mailComposeDelegate: MFMailComposeViewControllerDelegate?
    var messageComposeDelegate: MFMessageComposeViewControllerDelegate?
    
    override var contact: ContactModel? {
        didSet {
            prepareArrViewModel()
        }
    }
    
    func didClickEdit(from viewController: UIViewController) {
        guard let contact = contact else {
            return
        }
        AppRouter.shared.presentEditContactVC(selectedContact: contact, from: viewController)
    }
    
    func callNumber() {
        guard let phoneNumber = contact?.phoneNumber, let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") else {
            return
        }
        guard UIApplication.shared.canOpenURL(phoneCallURL) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(phoneCallURL as URL)
        }
    }
    
    func sendEmailIfAvailable(from viewController: UIViewController) {
        guard let emailId = contact?.email, MFMailComposeViewController.canSendMail() else {
            return
        }
        
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = mailComposeDelegate
        mailComposeVC.setToRecipients([emailId])
        AppRouter.shared.present(mailComposeVC, from: viewController)
    }
    
    func sendMessageIfAvailable(from viewController: UIViewController) {
        guard let phoneNumber = contact?.phoneNumber, MFMessageComposeViewController.canSendText() else {
            return
        }
        let controller = MFMessageComposeViewController()
        controller.body = Constants.emptyString
        controller.recipients = [phoneNumber]
        controller.messageComposeDelegate = messageComposeDelegate
        AppRouter.shared.present(controller, from: viewController)
    }
    
    //MARK: private
    private func prepareArrViewModel() {
        guard let contact = contact else {
            return
        }
        let arr = [LabelTextFieldViewModelTitle.mobile, LabelTextFieldViewModelTitle.email]
        arrViewModel = AppModelMapper.mapContactToLabelTextFieldViewModelArr(contact: contact, arrVMTitle: arr, editable: false)
    }
}
