//
//  LoginView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/12/21.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var user: FirebaseUserViewModel

    @State private var emailBorder: Color = Color("darkInvert")
    @State private var emailErrorOpacity: Double = 0.0

    @State private var passwordBorder: Color = Color("darkInvert")
    @State private var passwordVisible: Bool = false
    @State private var passwordErrorOpacity: Double = 0.0

    @State private var firebaseError: String = "No Errors"
    @State private var firebaseErrorOpacity: Double = 0.0

    @State private var loginSelected: Bool = false

    var body: some View {
        VStack {
            // MARK: - Email TextField
            VStack(alignment: .leading, spacing: 1) {
                TextField("", text: self.$user.email)
                    .padding(.all)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .modifier(PlaceholderStyle(showPlaceHolder: self.user.email.isEmpty, placeholder: "Email"))
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(emailBorder, lineWidth: 2)
                            .foregroundColor(Color(.systemBackground))
                    )
                    .onChange(of: self.user.email, perform: { _ in
                        if self.user.isEmpty(field: self.user.email) {
                            emailBorder = .red
                            emailErrorOpacity = 1.0
                        } else {
                            emailBorder = .green
                            emailErrorOpacity = 0.0
                        }
                    })
                Text("Enter Email")
                    .padding(.leading, 16.0)
                    .foregroundColor(.red.opacity(emailErrorOpacity))
                    .font(.system(size: 11.0))
            }

            // MARK: - Password TextField
            VStack(alignment: .leading, spacing: 1) {
                HStack {
                    Group {
                        if passwordVisible {
                            TextField("", text: self.$user.password)
                        } else {
                            SecureField("", text: self.$user.password)
                        }
                    }
                    .padding(.all)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .modifier(PlaceholderStyle(showPlaceHolder: self.user.password.isEmpty, placeholder: "Password"))
                    .onChange(of: self.user.password, perform: { _ in
                        if self.user.isEmpty(field: self.user.password) {
                            passwordBorder = .red
                            passwordErrorOpacity = 1.0
                        } else {
                            passwordBorder = .green
                            passwordErrorOpacity = 0.0
                        }
                    })

                    // Button to change password visibility
                    Button(action: {
                        passwordVisible.toggle()
                    }, label: {
                        Image(systemName: passwordVisible ? "eye.fill" : "eye.slash.fill")
                    })
                    .padding(.all)
                    .accentColor(Color("darkInvert"))
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(passwordBorder, lineWidth: 2)
                        .foregroundColor(Color(.systemBackground))
                )
                Text("Enter Password")
                    .padding(.leading, 16.0)
                    .foregroundColor(.red.opacity(passwordErrorOpacity))
                    .font(.system(size: 11.0))
            }

            // MARK: - Login Button
            Button(action: {
                if loginSelected == false {
                    self.loginSelected = true
                    // Validate all Fields
                    if emailBorder == .red || passwordBorder == .red {
                        return
                    }

                    user.loginUser(email: self.user.email.trimmingCharacters(in: .whitespacesAndNewlines), password: self.user.password.trimmingCharacters(in: .whitespacesAndNewlines)) { (result) in
                        switch result {
                        case .failure(let error):
                            self.loginSelected = false
                            firebaseError = error.localizedDescription
                            firebaseErrorOpacity = 1.0
                            return
                        case .success(_):
                            firebaseErrorOpacity = 0.0
                            print("Login Success")
                        }
                    }
                } else {
                    print("Don't Spam Button")
                }
            }, label: {
                Text("Login")
                    .padding(.all)
                    .foregroundColor(Color(.systemBackground))
                    .frame(width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 1.6))
                    .background(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 20)
            })
            .accentColor(.blue)

            // MARK: - Forgot Password
            NavigationLink(destination: ForgotPasswordView(),
                           label: {
                            Text("Forgot Password?")
                                .foregroundColor(.blue)
                           })

            // MARK: - Firebase Error display
            Text(firebaseError)
                .foregroundColor(.red.opacity(firebaseErrorOpacity))

            // Move Everything to the top of page
            Spacer()
        }
        .padding(.all)
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Account Login")
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(FirebaseUserViewModel())
    }
}
