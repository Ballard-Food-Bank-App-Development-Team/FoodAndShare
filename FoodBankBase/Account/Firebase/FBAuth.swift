//
//  FBAuth.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/21/21.
//

import Foundation
import Firebase

struct FBAuth {
    var userInfo: UserInfo

    // MARK: - Sign Up Function
    static func signUpUser(firstName: String, lastName: String, email: String, password: String, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        // Create user
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            // Check for errors
            if error != nil {
                completionHandler(.failure(error!))
                return
            }
            // Add user to FBstore
            let database = Firestore.firestore()
            database.collection("users").document(result!.user.uid).setData([
                "uid" : result!.user.uid,
                "firstName" : firstName,
                "lastName" : lastName,
                "email" : result!.user.email!
                // Check for errors
            ]) { err in
                if err != nil {
                    completionHandler(.failure(err!))
                    return
                }
                // Success
                completionHandler(.success(true))
            }
        }
    }

    // MARK: - Sign in Function
    static func loginUser(email: String, password: String, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        // Sign User In
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            // Check for errors
            if error != nil {
                completionHandler(.failure(error!))
                return
            }
            // Fetch Full Name

            // Fetch firstName and lastName
            let database = Firestore.firestore()
            let docRef = database.collection("users").document(authResult!.user.uid)

            docRef.getDocument { (document, error) in
                // Check for errors
                if error != nil {
                    completionHandler(.failure(error!))
                    return
                }

                let firstName: String? = document!.data()!["firstName"] as? String
                let lastName: String? = document!.data()!["lastName"] as? String

                // Set UserDefauls
                UserDefaults.standard.set(firstName, forKey: "firstName")
                UserDefaults.standard.set(lastName, forKey: "lastName")
                UserDefaults.standard.set(authResult!.user.uid, forKey: "uid")
                UserDefaults.standard.set(email, forKey: "email")

                // Success
                completionHandler(.success(true))
            }
        }
    }

    // MARK: - Forgot/Reset Password Function
    func resetPassword(email: String, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                completionHandler(.failure(error!))
            }
        }
    }

    // MARK: - Logout Function
    func logoutUser() {
    }
}
