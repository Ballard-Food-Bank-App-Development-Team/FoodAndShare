//
//  ForgotPasswordView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/15/21.
//

import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @Environment(\.presentationMode) var presentation
    
    @State private var email: String = ""
    @State private var error: String = ""

    var body: some View {
        VStack {
            TextField("", text: $email)
                .padding(.all)
                .disableAutocorrection(true)
                .modifier(PlaceholderStyle(showPlaceHolder: self.email.isEmpty, placeholder: "Email"))
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color("darkInvert"), lineWidth: 2)
                        .foregroundColor(Color(.systemBackground))
                )
            Button(action: {
                Auth.auth().sendPasswordReset(withEmail: self.email) { (error) in
                    if error != nil {
                        self.error = error!.localizedDescription
                    }
                }
            }, label: {
                Text("Send Reset Email")
            })
            .padding()
            .foregroundColor(Color(.systemBackground))
            .frame(width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 2))
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.blue)
            )
            .padding()
            
            Text(error)
                .foregroundColor(.red)
                .padding()
            Spacer()
        }
        .padding(.all)
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Forgot Password")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: { presentation.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "arrow.backward")
                    .imageScale(.large)
            })
        )
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
