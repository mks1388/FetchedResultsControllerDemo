//
//  Constants.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import Foundation

struct Constants {
    static let numberSign = "#"
    static let emptyString = ""
    
    struct UI {
        static let favIconName = "home_favourite"
        
        static let favButtonIconName = "favourite_button"
        static let favButtonIconSelectedName = "favourite_button_selected"
        
        static let callButtonIconName = "call_button"
        static let cameraButtonIconName = "camera_button"
        static let emailButtonIconName = "email_button"
        static let messageButtonIconName = "message_button"
        static let placeholderImageName = "placeholder_photo"
        
        static let contactCellDefaultHeight = 64.0
        static let labelTaxtCellDefaultHeight = 56.0
        
        static let ok = "OK"
        
        static let contactListTitle = "Contact"
        
        static let addContactHeaderHeight = 168.0
        static let ContactDetailHeaderHeight = 283.0
    }
    
    struct ErrorMessage {
        static let defaultTitle = "Error"
        static let validationTitle = "Validation Error"
        static let defaultMessage = "Something went wrong, please try again later."
        
        static let invalidFirstName = "First Name is not valid."
        static let invalidLastName = "Last Name is not valid."
        static let invalidMobile = "Mobile is not valid."
        static let invalidEmail = "Email is not valid."
    }
    
    struct APIUrl {
        static let baseUrl = "https://gojek-contacts-app.herokuapp.com"
        
        static let contactsUrl = baseUrl + "/contacts.json"
        static let contactDetailBaseUrl = baseUrl + "/contacts"
    }
    
    struct StoryboardName {
        static let main = "Main"
    }
    
    
    struct PicOptions {
        static let camera = "Camera"
        static let library = "Photo Library"
        static let cancel = "Cancel"
    }
}


