//
//  AddressView.swift
//  Parks
//
//  Created by James Clifford on 10/27/24.
//

import SwiftUI

struct AddressView: View {
    
    var addresses : [AddressModel]
    
    var body: some View{
        VStack(alignment: .leading) {
            ForEach(addresses) { address in
                if address.type == "Physical" {
                    if !address.line1.isEmpty {
                        Text(address.line1)
                    }
                    if !address.line2.isEmpty {
                        Text(address.line2)
                    }
                    if !address.line3.isEmpty {
                        Text(address.line3)
                    }
                    HStack {
                        Text(address.city)
                        Text(address.stateCode)
                    }
                }
            }
        }
    }
}

