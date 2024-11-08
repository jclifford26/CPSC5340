//
//  ListView.swift
//  Assignment4
//
//  Created by James Clifford on 11/5/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ListView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("This is where my app will go!")
        }
        .padding()
        
        Button {
            logout()
            ContentView()
        } label: {
            Text("Log Out")
                .bold()
            
                .frame(width: 200, height: 40)
                .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.linearGradient(colors: [.green, .blue], startPoint: .top, endPoint: .bottomTrailing)))
                .foregroundColor(.white)
        }
        .padding(.top)
        .offset(y: 100)
    }
    func logout() {
            do {
                try Auth.auth().signOut()
                // Navigate back to the root view, which is ContentView
                if let window = UIApplication.shared.windows.first {
                    window.rootViewController = UIHostingController(rootView: ContentView())
                    window.makeKeyAndVisible()
                }
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }}


#Preview {
    ListView()
}
