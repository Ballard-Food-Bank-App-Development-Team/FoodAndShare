//
//  ContentView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/12/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userInfo: UserInfo

    // Hello Ben (delete this later)

    var body: some View {
        Group {
            if userInfo.isUserAutheticated == .undefined {
                Image(systemName: "gearshape.2")
            } else if userInfo.isUserAutheticated == .signedOut {
                AccountChoiceView()
            } else { // User must be signed in
                HomeView()
            }
        }
        .onAppear {
            self.userInfo.configureFirebaseStateDidChange()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
