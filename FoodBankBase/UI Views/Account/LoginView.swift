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
    
    @EnvironmentObject var userInfo: UserInfo
    
    @State private var email: String = ""
    @State private var emailBorder: Color = Color("darkInvert").opacity(0.7)
    @State private var showEmailPopover: Bool = false
    @State private var emailErrorOpacity: Double = 0.0
    
    @State private var password: String = ""
    @State private var passwordBorder: Color = Color("darkInvert").opacity(0.7)
    @State private var showPasswordPopover: Bool = false
    @State private var passwordVisible: Bool = false
    @State private var passwordErrorOpacity: Double = 0.0
    
    @State private var firebaseError: String = "No Errors"
    @State private var firebaseErrorOpacity: Double = 0.0
    
    var body: some View {
        VStack {
            // Email TextField
            VStack (spacing: 1) {
                TextField("", text: $email)
                    .padding(.all)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .modifier(PlaceholderStyle(showPlaceHolder: email.isEmpty, placeholder: "Email"))
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(emailBorder, lineWidth: 2)
                            .foregroundColor(Color(.systemBackground))
                    )
                    .onChange(of: email, perform: { newValue in
                        if isEmailValid(email.trimmingCharacters(in: .whitespacesAndNewlines)) {
                            emailBorder = .red
                            emailErrorOpacity = 1.0
                        }
                        else {
                            emailBorder = .green
                            emailErrorOpacity = 0.0
                        }
                    })
                HStack {
                    Text("Email is Not Valid")
                        .padding(.leading, 16.0)
                        .foregroundColor(.red.opacity(emailErrorOpacity))
                        .font(.system(size: 11.0))
                    Spacer()
                }
            }
            
            // Password TextField
            VStack (spacing: 1) {
                HStack {
                    Group {
                        if passwordVisible {
                            TextField("", text: $password)
                        }
                        else {
                            SecureField("", text: $password)
                        }
                    }
                    .padding(.all)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .modifier(PlaceholderStyle(showPlaceHolder: password.isEmpty, placeholder: "Password"))
                    .onChange(of: password, perform: { newValue in
                        if isPasswordValid(password.trimmingCharacters(in: .whitespacesAndNewlines)) {
                            passwordBorder = .red
                            passwordErrorOpacity = 1.0
                        }
                        else {
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
                    .accentColor(.black)
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(passwordBorder, lineWidth: 2)
                        .foregroundColor(Color(.systemBackground))
                )
                HStack {
                    Text("Password is Not Valid")
                        .padding(.leading, 16.0)
                        .foregroundColor(.red.opacity(passwordErrorOpacity))
                        .font(.system(size: 11.0))
                    Spacer()
                }
            }
            
            // Login Button
            Button(action: {
                // Validate all Fields
                if !( emailBorder == .green && passwordBorder == .green) {
                    return
                }
                
                // Create cleaned versions of data
                let emailClean = email.trimmingCharacters(in: .whitespacesAndNewlines)
                let passwordClean = password.trimmingCharacters(in: .whitespacesAndNewlines)
                
                // Atempt to login the user
                Auth.auth().signIn(withEmail: emailClean, password: passwordClean) { result, error in
                    
                    if error != nil {
                        // There was an error creating the user
                        firebaseError = error!.localizedDescription
                        firebaseErrorOpacity = 1.0
                    }
                    else
                    {
                        firebaseErrorOpacity = 0.0
                        
                        // Set user state
                        self.userInfo.isUserAutheticated = .signedIn
                        
                        // Transiiton to the home screen
                        print("Successfully Logged In")
                        print(self.userInfo.isUserAutheticated)
                    }
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
            
            // Firebase Error display
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
            leading: Button(action: { presentation.wrappedValue.dismiss() }) {
                Image(systemName: "arrow.backward")
                    .imageScale(.large)
            })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
