//
//  UserViewModel.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/12/21.
//

import Foundation

struct UserViewModel {
    var uid: String = ""
    var email: String = ""
    var password: String = ""
    var firstName: String = ""
    var lastName: String = ""

    // MARK: - Validation Checks
    func isEmpty(_ field: String) -> Bool {
        return field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func isEmailValid(_ email: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}")
        return !passwordTest.evaluate(with: email)
    }

    func isPasswordValid(_ password: String) -> Bool {
        let passwordTest =
                NSPredicate(format: "SELF MATCHES %@","^(?!=[.* ])(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!%*?&])([a-zA-Z0-9@$!%*?&]{8,})$")
        return !passwordTest.evaluate(with: password)
    }

    // MARK: - Validation Error Strings

    var firstNameErrorText: String = "Enter Your First Name"
    var lastNameErrorText: String = "Enter Your Last Name"
    var emailErrorText: String = "Enter a Valid Email"
    var passwordErrorText: String = "Password must contain an uppercase letter, a lowercase letter, a number, a special character, no spaces, and be at least 8 characters long"

}
