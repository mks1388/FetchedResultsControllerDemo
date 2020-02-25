//
//  MobilePredicate.swift
//  ContactsApp
//
//  Created by Mithilesh on 25/02/20.
//  Copyright © 2020 Mithilesh Kumar Singh. All rights reserved.
//

public struct MobilePredicate: RegexPredicate {
    public let regex = "^[0-9+]{0,1}+[0-9]{5,16}$"
}
