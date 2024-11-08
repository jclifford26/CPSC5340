//
//  ContentView.swift
//  Converter
//
//  Created by James Clifford on 10/19/24.
//

import SwiftUI

struct Converter: View {
    
    @ObservedObject var viewModel = CurrencyConverterViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                ForEach(viewModel.listOfCards) { card in
                    CurrencyItem(card: card)
                        .onTapGesture {
                            viewModel.flip(card: card)
                        }
                }
            }
        }
        .onAppear {
            viewModel.fetchCards()
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Converter()
    }
}
    

