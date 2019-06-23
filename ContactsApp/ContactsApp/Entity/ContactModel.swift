//
//  ContactModel.swift
//  ContactsApp
//
//  Created by Mithilesh Singh on 22/06/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import Foundation

//{"id":6179,"first_name":"AAAkash","last_name":"Gupta","email":"fdsfds@gmail.com","phone_number":"5656768777","profile_pic":"/images/missing.png","favorite":false,"created_at":"2019-06-23T04:06:48.243Z","updated_at":"2019-06-23T04:06:48.243Z"}

struct ContactModel: Codable {
    let id : Int
    var firstName : String
    var lastName : String
    var profilePicUrl : String
    var favorite : Bool
    let url : String?
    var phoneNumber : String?
    var email : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePicUrl = "profile_pic"
        case favorite = "favorite"
        case url = "url"
        case phoneNumber = "phone_number"
        case email = "email"
    }
}

extension ContactModel {
    var fullName: String {
        return firstName + " " + lastName
    }
    
    func getProfilePicUrl() -> URL? {
        let urlString = Constants.APIUrl.baseUrl + profilePicUrl
        return URL(string: urlString)
    }
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
