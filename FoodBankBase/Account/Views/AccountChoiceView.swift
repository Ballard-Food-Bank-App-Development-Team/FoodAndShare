//
//  AccountChoiceView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/12/21.
//

import SwiftUI

struct AccountChoiceView: View {
    @EnvironmentObject var user: FirebaseUserViewModel

    @State private var showAlert: Bool = false
    @State private var error: String = ""

    @State private var anonymousLoginSelected: Bool = false

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

                Button(action: {
                    if self.anonymousLoginSelected == false {
                        self.anonymousLoginSelected = true
                        self.user.signInAnonymously { (result) in
                            switch result {
                            case .failure(let err):
                                self.anonymousLoginSelected = false
                                self.error = err.localizedDescription
                                self.showAlert = true
                            case .success(_):
                                print("Guest Login Success")
                            }
                        }
                    } else {
                        print("Don't Spam Button")
                    }
                }, label: {
                    Text("Guest Login")
                        .padding(.all)
                        .foregroundColor(Color(.systemBackground))
                        .frame(width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 3))
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("darkInvert"))
                        )

                })
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error Try Again"), message: Text(self.error), dismissButton: .default(Text("OK")))
                }

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
