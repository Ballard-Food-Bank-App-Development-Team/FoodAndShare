//
//  UserInfo.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/15/21.
//

import Foundation

class UserInfo: ObservableObject {
    enum FBAuthState {
        case undefined, signedOut, signedIn
    }
    @Published var isUserAutheticated: FBAuthState = .undefined
    @Published var user: FBUser = .init(firstname: "", lastname: "", email: "", uid: "")
    
    var authStateDidChangeListnerHandle: AuthStateDidChangeListnerHandle?
    
    func configureFirebaseStateDidChange() {
        self.isUserAutheticated = .signedOut
        //self.isUserAutheticated = .signedIn
    }
}
