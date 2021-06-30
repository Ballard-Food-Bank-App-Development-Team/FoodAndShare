//
//  FSFetch.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/21/21.
//

import Foundation
import Firebase

struct FSFetch {

    static func fetchFullName(uid: String, completionHandler: @escaping ((Result<Bool, Error>) -> Void)) -> [Any?] {
        // Fetch firstName and lastName
        let database = Firestore.firestore()
        let docRef = database.collection("users").document(uid)

        var firstName: Any?
        var lastName: Any?
        docRef.getDocument { (document, error) in
            // Check for errors
            if error != nil {
                completionHandler(.failure(error!))
                return
            }

            firstName = document!.data()!["firstName"]
            lastName = document!.data()!["lastName"]
        }
        return [firstName, lastName]
    }
}
