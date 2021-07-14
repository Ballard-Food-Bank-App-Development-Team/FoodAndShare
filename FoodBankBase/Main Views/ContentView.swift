//
//  ContentView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/12/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var user: FirebaseUserViewModel

    var body: some View {
        Group {
            if self.user.isUserAuthenticated == .undefined {
                Text("Loading...")
            } else if self.user.isUserAuthenticated == .signedOut {
                AccountChoiceView()
            } else {
                HomeView()
            }
        }
        .onAppear {
            self.user.checkUserState()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(FirebaseUserViewModel())
    }
}
