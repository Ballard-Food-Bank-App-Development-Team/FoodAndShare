//
//  FirebaseErrors.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/21/21.
//

import Foundation

enum FirebaseErrors: Error {
    case noUserSignedIn
    case documentDoesNotExist
}

extension FirebaseErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noUserSignedIn:
            return NSLocalizedString("Description of No User Signed In", comment: "No User Sigend In")
        case .documentDoesNotExist:
            return NSLocalizedString("Description of Document Doesn't Exisit", comment: "Document Doesn't Exisit")
        }
    }
}
