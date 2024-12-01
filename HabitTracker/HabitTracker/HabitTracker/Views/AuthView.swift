//
//  AuthView.swift
//  HabitTracker
//
//  Created by James Clifford on 11/15/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    
    var body: some View {
        Group {
            if userIsLoggedIn {
                ContentView()
            } else {
                authContent
            }
        }
        .onAppear {
            Auth.auth().addStateDidChangeListener { _, user in
                userIsLoggedIn = (user != nil)
            }
        }
    }
    
    var authContent: some View {
        ZStack {
            Color.black
            backgroundGradient
            VStack(spacing: 20) {
                headerText
                emailField
                passwordField
                signUpButton
                loginButton
            }
            .frame(width: 350)
        }
        .ignoresSafeArea()
    }
    
    var backgroundGradient: some View {
        RoundedRectangle(cornerRadius: 30, style: .continuous)
            .foregroundStyle(.linearGradient(colors: [.green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: 1000, height: 400)
            .rotationEffect(.degrees(135))
            .offset(y: -350)
    }
    
    var headerText: some View {
        Text("Habit Tracker")
            .foregroundColor(.white)
            .font(.system(size: 40, weight: .bold, design: .rounded))
            .offset(y: -100)
    }
    
    var emailField: some View {
        VStack {
            TextField("Email", text: $email)
                .authFieldStyle()
                .placeholder(when: email.isEmpty) {
                    Text("Email").authPlaceholderStyle()
                }
            divider
        }
    }
    
    var passwordField: some View {
        VStack {
            SecureField("Password", text: $password)
                .authFieldStyle()
                .placeholder(when: password.isEmpty) {
                    Text("Password").authPlaceholderStyle()
                }
            divider
        }
    }
    
    var divider: some View {
        Rectangle()
            .frame(width: 350, height: 1)
            .foregroundColor(.white)
    }
    
    var signUpButton: some View {
        Button(action: { authenticateUser(isRegistration: true) }) {
            Text("Sign Up")
                .authButtonStyle()
        }
        .padding(.top)
        .offset(y: 100)
    }
    
    var loginButton: some View {
        Button(action: { authenticateUser(isRegistration: false) }) {
            Text("Already have an account? Login")
                .foregroundColor(.white)
                .bold()
        }
        .padding(.top)
        .offset(y: 110)
    }
    
    func authenticateUser(isRegistration: Bool) {
        if isRegistration {
            Auth.auth().createUser(withEmail: email, password: password) { _, error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { _, error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func authButtonStyle() -> some View {
        self.bold()
            .frame(width: 200, height: 40)
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.linearGradient(colors: [.green, .blue], startPoint: .top, endPoint: .bottomTrailing)))
            .foregroundColor(.white)
    }
    
    func authFieldStyle() -> some View {
        self.foregroundColor(.white)
            .textFieldStyle(.plain)
    }
    
    func authPlaceholderStyle() -> some View {
        self.foregroundColor(.white).bold()
    }
}
