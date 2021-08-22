//
//  FirebaseUser.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 7/4/21.
//

import Foundation
import FirebaseFirestoreSwift

struct FirebaseUser: Identifiable, Codable {
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case email
        case role
    }

    var id: String? = UUID().uuidString
    var firstName: String
    var lastName: String
    var email: String
    var role: String

    init(firstname: String = "", lastName: String = "", email: String = "", role: String = "User") {
        self.firstName = firstname
        self.lastName = lastName
        self.email = email
        self.role = role
    }
}
