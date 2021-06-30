//
//  AccountChoiceView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/12/21.
//

import SwiftUI

struct AccountChoiceView: View {
    @EnvironmentObject var userInfo: UserInfo

    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                Spacer()
                Spacer()

                NavigationLink(destination: SignUpView()) {
                    Text("Sign Up")
                        .padding(.all)
                        .foregroundColor(Color("darkInvert"))
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("darkInvert"), lineWidth: 2)
                        .foregroundColor(.green)
                )
                NavigationLink(destination: LoginView()) {
                    Text("Login")
                        .padding(.all)
                        .foregroundColor(Color("darkInvert"))
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("darkInvert"), lineWidth: 2)
                        .foregroundColor(.blue)
                )

                Spacer()
            }
            .navigationTitle("Account Setup")
        }
        .accentColor(Color("darkInvert"))
    }
}

struct AccountChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        AccountChoiceView()
    }
}
