//
//  UserInfo.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/21/21.
//

import Foundation

class UserInfo: ObservableObject {

    @Published var signedIn: Bool = false
    @Published var user: FBUser = .init(uid: "", firstName: "", lastName: "", email: "")

    func checkUserState() {
        if UserDefaults.standard.string(forKey: "firstName") != nil {
            updateUserStateToSignedIn()
        } else {
            signedIn = false
        }
    }

    func updateUserStateToSignedIn() {
        self.user.uid = UserDefaults.standard.string(forKey: "uid")!
        self.user.firstName = UserDefaults.standard.string(forKey: "firstName")!
        self.user.lastName = UserDefaults.standard.string(forKey: "lastName")!
        self.user.email = UserDefaults.standard.string(forKey: "email")!
        signedIn = true
    }

    func updateUserStateToSignedOut() {

    }
}

struct FBUser {
    var uid: String?
    var firstName: String?
    var lastName: String?
    var email: String?

    init(uid: String, firstName: String, lastName: String, email: String) {
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}
