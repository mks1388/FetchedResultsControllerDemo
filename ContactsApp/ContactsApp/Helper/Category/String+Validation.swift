//
//  String+Validation.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import Foundation

extension String {
    func isNumber() -> Bool {
        let num = Int(self)
        return num != nil
    }
}
