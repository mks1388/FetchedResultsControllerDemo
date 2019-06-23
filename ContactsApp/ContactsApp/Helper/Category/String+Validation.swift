//
//  String+Validation.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return regexSatisfied(regex: emailRegEx)
    }
    
    func isValidMobile() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        return regexSatisfied(regex: phoneRegex)
    }
    
    func isNumber() -> Bool {
        let num = Int(self)
        return num != nil
    }
    
    //MARK: Private
    private func regexSatisfied(regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = predicate.evaluate(with: self)
        
        return result
    }
}
