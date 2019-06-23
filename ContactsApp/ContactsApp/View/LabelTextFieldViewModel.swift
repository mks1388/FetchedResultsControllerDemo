//
//  AddContactViewModel.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 23/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit

enum LabelTextFieldViewModelTitle: String, CaseIterable {
    case firstName = "First Name"
    case lastName = "Last Name"
    case mobile = "Mobile"
    case email = "Email"
    
    func getJSONKey() -> String{
        switch self {
        case .firstName:
            return "first_name"
        case .lastName:
            return "last_name"
        case .email:
            return "email"
        case .mobile:
            return "phone_number"
        }
    }
}

struct LabelTextFieldViewModel {
    let title: LabelTextFieldViewModelTitle
    let value: String?
    let editable: Bool
}
