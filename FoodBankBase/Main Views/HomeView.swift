//
//  HomeView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/17/21.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @EnvironmentObject var userInfo: UserInfo

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Food Bank Base \(userInfo.user.firstName)")
                    .padding(.all)

                Spacer()
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
        .accentColor(Color("darkInvert"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
