//
//  AccountChoiceView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/12/21.
//

import SwiftUI

struct AccountChoiceView: View {
    @EnvironmentObject var user: FirebaseUserViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                Spacer()

                NavigationLink(destination: SignUpView()) {
                    Text("Sign Up")
                        .padding(.all)
                        .foregroundColor(Color(.systemBackground))
                        .frame(width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 3))
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("darkInvert"))
                        )
                }

                NavigationLink(destination: LoginView()) {
                    Text("Login")
                        .padding(.all)
                        .foregroundColor(Color(.systemBackground))
                        .frame(width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 3))
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("darkInvert"))
                        )
                }
                /*
                Button(action: {
                    
                }, label: {
                    Text("Continue as Guest")
                        .padding(.all)
                        .foregroundColor(Color(.systemBackground))
                        .frame(width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 3))
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("darkInvert"))
                        )
                })
                */
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
            .environmentObject(FirebaseUserViewModel())
    }
}
