//
//  AccountChoiceView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/12/21.
//

import SwiftUI

struct AccountChoiceView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userInfo: UserInfo

    var body: some View {
        VStack(spacing: 15) {
            Spacer()

            NavigationLink(destination: SignUpView()) {
                Text("Sign Up")
                    .padding(.all)
                    .foregroundColor(Color("darkInvert"))
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.green)
                    .border(Color("darkInvert"), width: 2)
            )
            NavigationLink(destination: LoginView()) {
                Text("Login")
                    .padding(.all)
                    .foregroundColor(Color("darkInvert"))
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.blue)
                    .border(Color("darkInvert"), width: 2)
            )
        }
        .navigationTitle("Account Setup")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                presentation.wrappedValue.dismiss()
            }
            , label: {
                Image(systemName: "arrow.backward")
                    .imageScale(.large)
            })
        )
    }
}

struct AccountChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        AccountChoiceView()
    }
}
