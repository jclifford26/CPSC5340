//
//  AddressModel.swift
//  Parks
//
//  Created by James Clifford on 10/27/24.
//

import Foundation

struct AddressModel : Codable, Identifiable {
    var id : UUID {
        return UUID()
    }
    let postalCode : String
    let city : String
    let stateCode : String
    let line1 : String
    let type : String
    let line3 : String
    let line2 : String
}
