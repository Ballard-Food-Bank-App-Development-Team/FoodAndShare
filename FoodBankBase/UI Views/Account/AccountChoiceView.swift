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
        VStack (spacing: 15) {
            NavigationLink(destination: SignUpView()) {
                Text("Sign Up")
                    .padding(.all)
                    .foregroundColor(Color("darkInvert"))
            }
            NavigationLink(destination: LoginView()) {
                Text("Login")
                    .padding(.all)
                    .foregroundColor(Color("darkInvert"))
            }
        }
        .navigationTitle("Account Setup")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: { presentation.wrappedValue.dismiss() }) {
                Image(systemName: "arrow.backward")
                    .imageScale(.large)
            })
    }
}

struct AccountChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        AccountChoiceView()
    }
}
