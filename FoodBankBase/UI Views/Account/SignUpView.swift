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
    
    @EnvironmentObject var userInfo: UserInfo
    
    @State private var firstName: String = ""
    @State private var firstNameBorder: Color = Color("darkInvert").opacity(0.7)
    @State private var showFirstNamePopover: Bool = false
    @State private var firstNameErrorOpacity: Double = 0.0
    
    @State private var lastName: String = ""
    @State private var lastNameBorder: Color = Color("darkInvert").opacity(0.7)
    @State private var showLastNamePopover: Bool = false
    @State private var lastNameErrorOpacity: Double = 0.0
    
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
        
        VStack(alignment: .center, spacing: 5) {
            HStack (spacing: 18) {
                // First Name TextField
                VStack (spacing: 1) {
                    TextField("", text: $firstName)
                        .padding(.all)
                        .disableAutocorrection(true)
                        .modifier(PlaceholderStyle(showPlaceHolder: firstName.isEmpty, placeholder: "First Name"))
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(firstNameBorder, lineWidth: 2)
                                .foregroundColor(Color("textFieldBackground"))
                        )
                        .onChange(of: firstName, perform: { newValue in
                            if firstName.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                                firstNameBorder = .red
                                firstNameErrorOpacity = 1.0
                            }
                            else {
                                firstNameBorder = .green
                                firstNameErrorOpacity = 0.0
                            }
                        })
                    HStack {
                        Text("Please Fill in Field")
                            .padding(.leading, 16.0)
                            .foregroundColor(.red.opacity(firstNameErrorOpacity))
                            .font(.system(size: 11.0))
                        Spacer()
                    }
                }
                
                // Last Name TextField
                VStack (spacing: 1) {
                    TextField("", text: $lastName)
                        .padding(.all)
                        .disableAutocorrection(true)
                        .modifier(PlaceholderStyle(showPlaceHolder: lastName.isEmpty, placeholder: "Last Name"))
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lastNameBorder, lineWidth: 2)
                                .foregroundColor(Color(.systemBackground))
                        )
                        .onChange(of: lastName, perform: { newValue in                   if lastName.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                            lastNameBorder = .red
                            lastNameErrorOpacity = 1.0
                        }
                        else {
                            lastNameBorder = .green
                            lastNameErrorOpacity = 0.0
                        }
                        })
                    HStack {
                        Text("Please Fill in Field")
                            .padding(.leading, 16.0)
                            .foregroundColor(.red.opacity(lastNameErrorOpacity))
                            .font(.system(size: 11.0))
                        Spacer()
                    }
                }
            }
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
                    Text("Please Enter a Valid Email")
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
                    Text("Password Must Contain: an Uppercase Letter, a Lowercase Letter, a Number, a Special Character, No Spaces, and be at Least 8 Characters Long")
                        .padding(.leading, 16.0)
                        .foregroundColor(.red.opacity(passwordErrorOpacity))
                        .font(.system(size: 11.0))
                    Spacer()
                }
            }
            
            
            // Sign Up Button
            Button(action: {
                // Validate all Fields
                if !(firstNameBorder == .green && lastNameBorder == .green && emailBorder == .green && passwordBorder == .green) {
                    return
                }
                
                // Create cleaned versions of data
                let firstNameClean = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
                let lastNameClean = lastName.trimmingCharacters(in: .whitespacesAndNewlines)
                let emailClean = email.trimmingCharacters(in: .whitespacesAndNewlines)
                let passwordClean = password.trimmingCharacters(in: .whitespacesAndNewlines)
                // Create the User
                Auth.auth().createUser(withEmail: emailClean, password: passwordClean) { result, error in
                    
                    // Check for errors
                    if error != nil
                    {
                        // There was an error creating the user
                        firebaseError = error!.localizedDescription
                        firebaseErrorOpacity = 1.0
                    }
                    else
                    {
                        firebaseErrorOpacity = 0.0
                        
                        // User successfuly created (store user in database)
                        let db = Firestore.firestore()
                        
                        db.collection("users").addDocument(data: ["firstname" : firstNameClean, "lastname" : lastNameClean, "uid" : result!.user.uid ]) { error in
                            
                            if error != nil
                            {
                                // Show error message
                                firebaseError = error!.localizedDescription
                                firebaseErrorOpacity = 1.0
                            }
                        }
                        firebaseErrorOpacity = 0.0
                        
                        // Transition to the home screen
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
            
            // Firebase Error display
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
            leading: Button(action: { presentation.wrappedValue.dismiss() }) {
                Image(systemName: "arrow.backward")
                    .imageScale(.large)
            })
    }
}

func isEmailValid(_ email: String) -> Bool {
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
    
    if email.range(of: regex, options: .regularExpression) != nil {
        return false
    }
    
    return true
}

func isPasswordValid(_ password: String) -> Bool {
    let regex = "^(?!=[.* ])(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!%*?&])([a-zA-Z0-9@$!%*?&]{8,})$"
    
    if password.range(of: regex, options: .regularExpression) != nil {
        return false
    }
    
    return true
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .preferredColorScheme(.light)
    }
}

// TextField custom modifier
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
