//
//  FirebaseUser.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 7/4/21.
//

import Foundation
import FirebaseFirestoreSwift

struct FirebaseUser: Identifiable, Codable {
    var id: String? = UUID().uuidString
    var firstName: String?
    var lastName: String?
    var email: String?

    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case email
    }
}
