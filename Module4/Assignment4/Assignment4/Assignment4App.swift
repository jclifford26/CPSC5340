//
//  Assignment4App.swift
//  Assignment4
//
//  Created by James Clifford on 11/4/24.
//

import SwiftUI
import Firebase

@main
struct Assignment4App: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
