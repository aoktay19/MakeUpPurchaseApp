//
//  AuthenticationViewModel.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 16.01.2024.
//

import Foundation
import FirebaseAuth

@MainActor
class AuthenticationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isAuthenticated = false
    @Published var isSignUp = false
    @Published var errorMessage = ""
    @Published var user: User?
    @Published var displayName = ""

    init() {
        registerAuthStateHandler()
    }

    private var authStateHandler: AuthStateDidChangeListenerHandle?

    func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
                self.user = user
                self.displayName = user?.email ?? ""
            }
        }
    }

    func signInWithEmailPassword() async -> Bool {
        do {
          try await Auth.auth().signIn(withEmail: self.email, password: self.password)
          isAuthenticated = true
          return true
        }
        catch  {
          print(error)
          errorMessage = error.localizedDescription
          return false
        }
    }

    func signUpWithEmailPassword() async -> Bool {
        do  {
            try await Auth.auth().createUser(withEmail: email, password: password)
            return true
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
            return false
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isAuthenticated = false
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }

    func deleteAccount() {
        user?.delete()
    }
}
