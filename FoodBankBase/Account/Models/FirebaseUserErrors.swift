//
//  FirebaseUserErrors.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 7/4/21.
//

import Foundation

enum FirebaseUserError: Error {
    case noUserSignedIn
    case documentDoesNotExist
}

extension FirebaseUserError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noUserSignedIn:
            return NSLocalizedString("Description of No User Signed In", comment: "No User Sigend In")
        case .documentDoesNotExist:
            return NSLocalizedString("Description of Document Doesn't Exisit", comment: "Document Doesn't Exisit")
        }
    }
}
