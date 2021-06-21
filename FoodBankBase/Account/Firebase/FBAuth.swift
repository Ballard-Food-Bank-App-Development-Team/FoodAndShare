//
//  FBAuth.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/21/21.
//

import Foundation
import Firebase

struct FBAuth {

    // MARK: - Sign Up Function
    static func signUpUser(email: String, password: String, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            // Check for errors
            if error == nil {
                completionHandler(.failure(error!))
                return
            }

            // Create user

                // Check for errors

            // Add user to FBstore

                // Check for errors

            // Update UserDefaults

        }
    }

    // MARK: - Sign in Function
    static func loginUser() {

    }

    // MARK: - Forgot/Reset Password Function
    static func resetPassword() {

    }

    // MARK: - Logout Function
    static func logoutUser() {

    }
}
