//
//  ContactModel.swift
//  Parks
//
//  Created by James Clifford on 10/27/24.
//

import Foundation

struct ContactModel : Codable {
    let phoneNumbers : [PhoneModel]
    let emailAddresses : [EmailModel]
}

struct PhoneModel : Codable {
    let phoneNumber : String
    let description : String
    let `extension` : String
    let type : String
}

struct EmailModel : Codable {
    let description : String
    let emailAddress : String
}
