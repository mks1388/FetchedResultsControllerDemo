//
//  AppModelMapper.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 23/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import Foundation

struct AppModelMapper {
    static func mapContactToLabelTextFieldViewModelArr(contact: ContactModel?, arrVMTitle: [LabelTextFieldViewModelTitle], editable: Bool) -> [LabelTextFieldViewModel] {
        var arrViewModel = [LabelTextFieldViewModel]()
        for title in arrVMTitle {
            let value: String
            switch title {
            case .firstName:
                value = contact?.firstName ?? Constants.emptyString
            case .lastName:
                value = contact?.lastName ?? Constants.emptyString
            case .mobile:
                value = contact?.phoneNumber ?? Constants.emptyString
            case .email:
                value = contact?.email ?? Constants.emptyString
            }
            let model = LabelTextFieldViewModel(title: title, value: value, editable: editable)
            arrViewModel.append(model)
        }
        return arrViewModel
    }
}
