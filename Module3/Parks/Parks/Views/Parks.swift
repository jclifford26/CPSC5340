//
//  ContentView.swift
//  Parks
//
//  Created by James Clifford on 10/27/24.
//

import SwiftUI

struct Parks: View {
    
    @ObservedObject var parksvm = ParksViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(parksvm.parksData) { park in
                    NavigationLink {
                        ParkDetail(park: park)
                    } label: {
                        Text(park.fullName)
                    }
                }
                
            }
            .task {
                await parksvm.fetchData()
            }
            .listStyle(.grouped)
            .navigationTitle("Parks")
            .alert(isPresented: $parksvm.hasError, error: parksvm.error) {
                Text("")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Parks()
    }
}
