//
//  RegexPredicate.swift
//  ContactsApp
//
//  Created by Mithilesh on 25/02/20.
//  Copyright © 2020 Mithilesh Kumar Singh. All rights reserved.
//

import Foundation

public protocol RegexPredicate {
    var regex: String { get }
    
    func evaluate(with input: String) -> Bool
}

extension RegexPredicate {
    public func evaluate(with input: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = predicate.evaluate(with: self)
        
        return result
    }
}
