//
//  UserInfo.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/21/21.
//

import Foundation

class UserInfo: ObservableObject {

    var uid: String?
    var firstName: String?
    var lastName: String?
    var email: String?

    var signedIn: Bool = false

    init() {
        if UserDefaults.standard.string(forKey: "uid") != nil {
            self.uid = UserDefaults.standard.string(forKey: "uid")
            self.firstName = UserDefaults.standard.string(forKey: "firstName")
            self.lastName = UserDefaults.standard.string(forKey: "lastName")
            self.email = UserDefaults.standard.string(forKey: "email")
            signedIn = true
        } else {
            signedIn = false
        }
    }

    func setUpNewUserAccount() {
        self.uid = UserDefaults.standard.string(forKey: "uid")
        self.firstName = UserDefaults.standard.string(forKey: "firstName")
        self.lastName = UserDefaults.standard.string(forKey: "lastName")
        self.email = UserDefaults.standard.string(forKey: "email")
        signedIn = true
    }
}
