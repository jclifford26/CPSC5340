//
//  ParkImageModel.swift
//  Parks
//
//  Created by James Clifford on 10/27/24.
//

import Foundation

struct ParkImageModel : Codable, Identifiable {
    let id = UUID()
    let credit : String
    let title : String
    let altText : String
    let caption : String
    let url : String
}
