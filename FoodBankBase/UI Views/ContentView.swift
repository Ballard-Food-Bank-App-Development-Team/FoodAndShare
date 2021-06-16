//
//  ContentView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/12/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Food Bank Base")
                    .padding(.all)
                
                Spacer()
            }
            .navigationTitle("Food Bank")
            .navigationBarItems(
                trailing:
                    NavigationLink(destination: transitionToAccountView()) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.title)
                            .padding(.all)
                    }
            )
        }
        .accentColor(Color("darkInvert"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}

struct transitionToAccountView: View {
    @EnvironmentObject var userInfo: UserInfo
    
    var body: some View {
        Group {
            if userInfo.isUserAutheticated == .undefined {
                Image(systemName: "gearshape.2")
            }
            else if userInfo.isUserAutheticated == .signedOut {
                AccountChoiceView()
            }
            else { // User must be signed in
                AccountSettingsView()
            }
        }
        .onAppear {
            self.userInfo.configureFirebaseStateDidChange()
        }
    }
}
