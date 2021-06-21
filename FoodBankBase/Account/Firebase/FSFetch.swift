//
//  FSFetch.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/21/21.
//

import Foundation
import Firebase

struct FSFetch {

    static func fetchFullName(uid: String, completionHandler: @escaping ((Result<Bool, Error>) -> Void)) -> [String] {
        // Fetch firstName and lastName
        let database = Firestore.firestore()
        let docRef = database.collection("users").document(uid)

        var firstName: String?
        var lastName: String?
        docRef.getDocument { (document, error) in
            // Check for errors
            if error != nil {
                completionHandler(.failure(error!))
                return
            }

            firstName = document?.data()?["firstName"] as? String
            lastName = document?.data()?["lastName"] as? String
        }
        return [firstName ?? "", lastName ?? ""]
    }
}
