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
    static func signUpUser(firstName: String, lastName: String, email: String, password: String, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        // Create user
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            // Check for errors
            if error == nil {
                completionHandler(.failure(error!))
                return
            }
            // Add user to FBstore
            let database = Firestore.firestore()
            database.collection("users").addDocument(
                data: [
                    "uid" : result!.user.uid,
                    "firstName" : firstName,
                    "lastName" : lastName,
                    "email" : result!.user.email!
                ]
                // Check for errors
            ) { (err) in
                if err == nil {
                    completionHandler(.failure(err!))
                    return
                }
            }

            // Set UserDefauls
            UserDefaults.standard.set(result!.user.uid, forKey: "uid")
            UserDefaults.standard.set(firstName, forKey: "firstName")
            UserDefaults.standard.set(lastName, forKey: "lastName")
            UserDefaults.standard.set(email, forKey: "email")
        }
    }

    // MARK: - Sign in Function
    static func loginUser(email: String, password: String, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        // Sign User In
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            // Check for errors
            if error == nil {
                completionHandler(.failure(error!))
                return
            }
            // Fetch Full Name
            let fullname = FSFetch.fetchFullName(uid: authResult!.user.uid) { (result) in
                switch result {
                case .failure(let err):
                    completionHandler(.failure(err))
                    return
                case .success(_):
                    print("Successfully got full name")
                }
            }
            // Set UserDefauls
            UserDefaults.standard.set(authResult!.user.uid, forKey: "uid")
            UserDefaults.standard.set(fullname[0], forKey: "firstName")
            UserDefaults.standard.set(fullname[1], forKey: "lastName")
            UserDefaults.standard.set(email, forKey: "email")
        }
    }

    // MARK: - Forgot/Reset Password Function
    func resetPassword() {

    }

    // MARK: - Logout Function
    func logoutUser() {

    }
}
