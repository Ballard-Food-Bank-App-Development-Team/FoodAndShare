//
//  FirebaseUserViewModel.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 7/4/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseUserViewModel: ObservableObject {
    enum FirebaseAuthState {
        case undefined, signedOut, signedIn
    }

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""

    @Published var isUserAuthenticated: FirebaseAuthState = .undefined
    @Published var userInfo: FirebaseUser = FirebaseUser()

    var handle: AuthStateDidChangeListenerHandle?

    private var database = Firestore.firestore()

    // MARK: - Validation Error Strings
    var firstNameErrorText: String = "Enter Your First Name"
    var lastNameErrorText: String = "Enter Your Last Name"
    var emailErrorText: String = "Enter a Valid Email"
    var passwordErrorText: String = "Must have an uppercase letter, a lowercase letter, a number, a special character, no spaces, and be at least 8 characters long"

    // MARK: - Text Field Validation
    func isEmpty(field: String) -> Bool {
        return field.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }

    func isEmailValid(email: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}")
        return !passwordTest.evaluate(with: email)
    }

    func isPasswordValid(password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?!=[.* ])(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!%*?&])([a-zA-Z0-9@$!%*?&]{8,})$")
        return !passwordTest.evaluate(with: password)
    }

    // MARK: - Firebase Auth
    func signUpUser(firstName: String, lastName: String, email: String, password: String, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        // Create user
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            // Check for errors
            if error != nil {
                completionHandler(.failure(error!))
                return
            }

            self.userInfo = FirebaseUser(firstname: firstName, lastName: lastName, email: email, role: "User")

            do {
                try self.database.collection("users").document(result!.user.uid).setData(from: self.userInfo)
            } catch let err {
                completionHandler(.failure(err))
                return
            }

            self.checkUserState()
            completionHandler(.success(true))
        }
    }

    func loginUser(email: String, password: String, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        // Sign User In
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            // Check for errors
            if error != nil {
                completionHandler(.failure(error!))
                return
            }

            self.checkUserState()
            completionHandler(.success(true))
        }
    }

    func signInAnonymously(completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signInAnonymously { (result, error) in
            if error != nil {
                completionHandler(.failure(error!))
                return
            }

            self.userInfo = FirebaseUser(firstname: "Anonymous", lastName: "User", role: "User")

            do {
                try self.database.collection("users").document(result!.user.uid).setData(from: self.userInfo)
            } catch let err {
                completionHandler(.failure(err))
                return
            }

            self.checkUserState()
            completionHandler(.success(true))
        }
    }

    func logoutUser(completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
        } catch let error {
            completionHandler(.failure(error))
            return
        }

        self.email = ""
        self.password = ""
        self.firstName = ""
        self.lastName = ""

        self.checkUserState()
        completionHandler(.success(true))
    }

    func checkUserState() {
        self.handle = Auth.auth().addStateDidChangeListener { (_, user) in
            if user == nil {
                self.isUserAuthenticated = .signedOut
                return
            }
            self.fetchUserData { (result) in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                    self.logoutUser { (result) in
                        switch result {
                        case .failure(let error):
                            print(error)
                        case .success(_):
                            print("Logged User Out")
                        }
                    }
                case .success(_):
                    self.isUserAuthenticated = .signedIn
                    print("Fetched User Data Succesfully")
                }
            }
        }
    }

    // MARK: - Firestore
    func fetchUserData(completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        // Check if the current user is for some reason not signed in
        if Auth.auth().currentUser == nil {
            completionHandler(.failure(FirebaseErrors.noUserSignedIn))
            return
        }

        // Setup the correct document to fetch from
        let user = Auth.auth().currentUser
        let docRef = database.collection("users").document(user!.uid)

        // Fetch document
        docRef.getDocument { (document, error) in
            // Check For errors
            if error != nil {
                completionHandler(.failure(error!))
                return
            }

            // try to fetch document and make it conform to FirebaseUser
            let result = Result {
                try document?.data(as: FirebaseUser.self)
            }
            // Check if successfull
            switch result {
            case .success(let firebaseUser):
                // The user or the document does not exisit
                if firebaseUser != nil {
                    self.userInfo = firebaseUser!
                    completionHandler(.success(true))
                } else {
                    completionHandler(.failure(FirebaseErrors.documentDoesNotExist))
                }
            case .failure(let err):
                completionHandler(.failure(err))
            }
        }
    }
}
