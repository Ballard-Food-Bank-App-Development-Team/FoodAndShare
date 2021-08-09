//
//  AccountSettingsView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/15/21.
//

import SwiftUI

struct AccountSettingsView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var user: FirebaseUserViewModel

    var body: some View {
        VStack {
            Form {
                Text("Name: \(self.user.firstName) \(self.user.lastName)")
            }
        }
        .onAppear {
            self.user.checkUserState()
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Account Settings")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: { presentation.wrappedValue.dismiss()
            }
            , label: {
                Image(systemName: "arrow.backward")
                    .imageScale(.large)
            }),
            trailing: Button(action: {
                self.user.logoutUser { (result) in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(_):
                        self.user.checkUserState()
                        print("Logged Out User")
                    }
                }
            }, label: {
                Text("Log Out")
            })
        )
    }
}

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView()
            .environmentObject(FirebaseUserViewModel())
    }
}
