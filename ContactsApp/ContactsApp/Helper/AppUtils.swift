//
//  AppUtils.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import Foundation
import UIKit

struct AppUtils {
    
    static func mapContactsIntoSections(arrContact: [ContactModel]) -> [ContactsSectionModel] {
        let groupedDictionary = Dictionary(grouping: arrContact) { (contact: ContactModel) in
            return String(contact.fullName.uppercased().prefix(1)).isNumber() ? Constants.numberSign : String(contact.fullName.uppercased().prefix(1))
        }
        var keys = groupedDictionary.keys.sorted()
        if keys.first == Constants.numberSign {
            let first = keys.removeFirst()
            keys.append(first)
        }
        
        let sections = keys.map{ ContactsSectionModel(title: $0, contacts: groupedDictionary[$0]!.sorted(by: {$0.fullName < $1.fullName})) }
        
        return sections
    }
    
    static func update(array: [ContactModel], with contact: ContactModel) -> [ContactsSectionModel] {
        var array = array
        if let index = array.firstIndex(where: {$0.id == contact.id}) {
            array[index] = contact
        } else {
            array.append(contact)
        }
        return mapContactsIntoSections(arrContact: array)
    }
}
