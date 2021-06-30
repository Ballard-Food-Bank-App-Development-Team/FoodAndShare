//
//  ContentView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/12/21.
//

import SwiftUI

struct ContentView: View {
     @EnvironmentObject var userInfo: UserInfo

    var body: some View {
        Group {
            if userInfo.signedIn {
                HomeView()
            } else { AccountChoiceView() }
        }
        .onAppear {
            self.userInfo.checkUserState()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
