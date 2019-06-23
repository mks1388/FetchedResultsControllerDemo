//
//  AppRouter.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import Foundation
import UIKit

class AppRouter {
    static let shared = AppRouter()
    
    private init() {}
    
    func showAlert(title: String?, message: String?, from viewController: UIViewController) {
        let alert = AppBuilder.shared.getAlert(title: title, message: message)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func presentAddContactVC(from parent: UIViewController) {
        guard let vc = AppBuilder.shared.getAddContactVC(selectedcontact: nil) else {
            return
        }
        parent.present(vc, animated: true, completion: nil)
    }
    
    func presentEditContactVC(selectedContact contact: ContactModel, from parent: UIViewController) {
        guard let vc = AppBuilder.shared.getAddContactVC(selectedcontact: contact) else {
            return
        }
        parent.present(vc, animated: true, completion: nil)
    }
    
    func pushContactDetailVC(selectedContact contact: ContactModel, from parent: UINavigationController) {
        guard let vc = AppBuilder.shared.getViewContactVC(selectedcontact: contact) else {
            return
        }
        parent.pushViewController(vc, animated: true)
    }
    
    func dismissVC(viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func present(_ viewController: UIViewController, from parent: UIViewController) {
        parent.present(viewController, animated: true, completion: nil)
    }
}
