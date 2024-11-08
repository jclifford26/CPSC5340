//
//  ConvertModel.swift
//  Converter
//
//  Created by James Clifford on 10/19/24.
//

import Foundation

struct ConvertModel<SomeType> : Identifiable {
    let id = UUID()
    var isFront : Bool = true
    let cardContent: SomeType
}

struct CurrencyItemModel {
    let currencyName : String
    let currencyCode : String
    let countryFlag : String
    let multiplier : Double
}

struct CryptoItemModel {
    let cryptoName : String
    let cryptoCode : String
    let multiplier : Double
}
