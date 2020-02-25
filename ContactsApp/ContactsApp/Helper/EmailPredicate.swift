//
//  EmailPredicate.swift
//  ContactsApp
//
//  Created by Mithilesh on 25/02/20.
//  Copyright © 2020 Mithilesh Kumar Singh. All rights reserved.
//

public struct EmailPredicate: RegexPredicate {
    public let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
}
