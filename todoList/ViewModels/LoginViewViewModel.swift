//
//  LoginViewViewModel.swift
//  todoList
//
//  Created by Trey Bertram on 2023-09-17.
//

import FirebaseAuth
import Foundation

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func login() {
            guard validate() else {
                return
            }

            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if let error = error as NSError? {
                    DispatchQueue.main.async {
                        switch error.code {
                        case AuthErrorCode.wrongPassword.rawValue:
                            self.errorMessage = "The password is incorrect."
                        case AuthErrorCode.invalidEmail.rawValue:
                            self.errorMessage = "The email address is not valid."
                        case AuthErrorCode.userNotFound.rawValue:
                            self.errorMessage = "The account does not exist."
                        default:
                            self.errorMessage = "Incorrect email address or password."
                        }
                    }
                } else {
                    // Successfully logged in
                    DispatchQueue.main.async {
                        self.errorMessage = ""
                    }
                }
            }
        }

    
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email address."
            return false
        }
        
        return true
    }
    
}
