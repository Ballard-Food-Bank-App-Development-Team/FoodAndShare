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

                Button(action: {
                    print(userInfo.user.firstName)
                }, label: {
                    Text("Button")
                })

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
            .onAppear {
                guard let uid = Auth.auth().currentUser?.uid else {
                    return
                }
                FBFirestore.retrieveFBUser(uid: uid) {(result) in
                    switch result {
                    case .failure(let error):
                        print("ERROR")
                        print(error.localizedDescription)
                    case .success(let user):
                        self.userInfo.user = user
                    }
                }
            }
        }
        .accentColor(Color("darkInvert"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
