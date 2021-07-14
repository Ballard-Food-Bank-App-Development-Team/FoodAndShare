//
//  HomeView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/17/21.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @EnvironmentObject var user: FirebaseUserViewModel

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Food Bank Bank \(self.user.userInfo.firstName!) \(self.user.userInfo.lastName!)")
                    .padding(.all)

                NavigationLink(
                    destination: DaySelectView(),
                    label: {
                        Text("Go To Calendar")
                            .padding(.all)
                    })

                Spacer()
            }
            .onAppear {
                self.user.checkUserState()
            }
            .navigationTitle("Food Bank")
            .navigationBarItems(
                trailing:
                    NavigationLink(destination: AccountSettingsView()) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.title)
                            .padding(.all)
                    }
            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(FirebaseUserViewModel())
    }
}
