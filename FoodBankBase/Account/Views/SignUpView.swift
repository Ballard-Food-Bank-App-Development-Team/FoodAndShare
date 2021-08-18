//
//  SignUpView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/12/21.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var user: FirebaseUserViewModel

    @State private var firstNameBorder: Color = Color("darkInvert")
    @State private var firstNameErrorOpacity: Double = 0.0

    @State private var lastNameBorder: Color = Color("darkInvert")
    @State private var lastNameErrorOpacity: Double = 0.0

    @State private var emailBorder: Color = Color("darkInvert")
    @State private var emailErrorOpacity: Double = 0.0

    @State private var passwordBorder: Color = Color("darkInvert")
    @State private var passwordVisible: Bool = false
    @State private var passwordErrorOpacity: Double = 0.0

    @State private var firebaseError: String = "No Errors"
    @State private var firebaseErrorOpacity: Double = 0.0

    var body: some View {

        VStack(alignment: .center, spacing: 5) {
            HStack(spacing: 18) {
                // MARK: - First Name TextField
                VStack(alignment: .leading, spacing: 1) {
                    TextField("", text: self.$user.firstName)
                        .padding(.all)
                        .disableAutocorrection(true)
                        .modifier(PlaceholderStyle(showPlaceHolder: self.user.firstName.isEmpty, placeholder: "First Name"))
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(firstNameBorder, lineWidth: 2)
                                .foregroundColor(Color("textFieldBackground"))
                        )
                        .onChange(of: self.user.firstName, perform: { _ in
                            if self.user.isEmpty(field: self.user.firstName.trimmingCharacters(in: .whitespacesAndNewlines)) {
                                firstNameBorder = .red
                                firstNameErrorOpacity = 1.0
                            } else {
                                firstNameBorder = .green
                                firstNameErrorOpacity = 0.0
                            }
                        })
                    Text(self.user.firstNameErrorText)
                        .padding(.leading, 16.0)
                        .foregroundColor(.red.opacity(firstNameErrorOpacity))
                        .font(.system(size: 11.0))
                }

                // MARK: - Last Name TextField
                VStack(alignment: .leading, spacing: 1) {
                    TextField("", text: self.$user.lastName)
                        .padding(.all)
                        .disableAutocorrection(true)
                        .modifier(PlaceholderStyle(showPlaceHolder: self.user.lastName.isEmpty, placeholder: "Last Name"))
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lastNameBorder, lineWidth: 2)
                                .foregroundColor(Color(.systemBackground))
                        )
                        .onChange(of: self.user.lastName, perform: { _ in
                            if self.user.isEmpty(field: self.user.lastName.trimmingCharacters(in: .whitespacesAndNewlines)) {
                                lastNameBorder = .red
                                lastNameErrorOpacity = 1.0
                            } else {
                                lastNameBorder = .green
                                lastNameErrorOpacity = 0.0
                            }
                        })
                    Text(self.user.lastNameErrorText)
                        .padding(.leading, 16.0)
                        .foregroundColor(.red.opacity(lastNameErrorOpacity))
                        .font(.system(size: 11.0))
                }
            }
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
                        if self.user.isEmailValid(email: self.user.email.trimmingCharacters(in: .whitespacesAndNewlines)) {
                            emailBorder = .red
                            emailErrorOpacity = 1.0
                        } else {
                            emailBorder = .green
                            emailErrorOpacity = 0.0
                        }
                    })
                Text(user.emailErrorText)
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
                        if self.user.isPasswordValid(password: self.user.password) {
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
                Text(self.user.passwordErrorText)
                    .padding(.leading, 16.0)
                    .foregroundColor(.red.opacity(passwordErrorOpacity))
                    .font(.system(size: 11.0))
            }

            // MARK: - Sign Up Button
            Button(action: {
                // Validate all Feilds
                if firstNameBorder == .red || lastNameBorder == .red || emailBorder == .red || passwordBorder == .red {
                    return
                }

                // Sign Up User
                user.signUpUser(
                    firstName: self.user.firstName.trimmingCharacters(in: .whitespacesAndNewlines),
                    lastName: self.user.lastName.trimmingCharacters(in: .whitespacesAndNewlines),
                    email: self.user.email.trimmingCharacters(in: .whitespacesAndNewlines),
                    password: self.user.password.trimmingCharacters(in: .whitespacesAndNewlines)
                ) { (result) in
                    switch result {
                    case .failure(let error):
                        firebaseError = error.localizedDescription
                        firebaseErrorOpacity = 1.0
                        return
                    case .success(_):
                        firebaseErrorOpacity = 0.0
                        print("Sign Up Success")
                    }
                }
            }
            , label: {
                Text("Sign Up")
                    .padding(.all)
                    .foregroundColor(Color(.systemBackground))
                    .frame(width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 1.6))
                    .background(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 20)
            })
            .accentColor(.blue)

            // MARK: - Firebase Error display
            Text(firebaseError)
                .foregroundColor(.red.opacity(firebaseErrorOpacity))

            // Move Everything to the top of page
            Spacer()
        }
        .padding(.all)
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Create Account")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: { presentation.wrappedValue.dismiss()
            }
            , label: {
                Image(systemName: "arrow.backward")
                    .imageScale(.large)
            })
        )
    }
}

// MARK: - TextField custom modifier
public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .padding(.horizontal, 15)
                    .foregroundColor(Color("placeholderText"))
            }
            content
                .foregroundColor(Color("darkInvert"))
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(FirebaseUserViewModel())
    }
}
