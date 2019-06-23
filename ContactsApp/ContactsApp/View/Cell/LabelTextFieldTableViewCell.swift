//
//  LabelTextFieldTableViewCell.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit

class LabelTextFieldTableViewCell: UITableViewCell, ReusableInterface {

    @IBOutlet weak var lblView: UILabel!
    @IBOutlet weak var textView: UITextField!
    
    func updateCell(model: LabelTextFieldViewModel) {
        lblView.text = model.title.rawValue
        textView.text = model.value ?? Constants.emptyString
        textView.isUserInteractionEnabled = model.editable
        textView.borderStyle = model.editable ? .roundedRect : .none
    }
}
