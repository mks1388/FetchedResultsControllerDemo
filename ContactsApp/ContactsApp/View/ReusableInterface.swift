//
//  ReusableInterface.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import Foundation

protocol ReusableInterface {
    static var reuseIdentifier: String {get}
}

extension ReusableInterface {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
