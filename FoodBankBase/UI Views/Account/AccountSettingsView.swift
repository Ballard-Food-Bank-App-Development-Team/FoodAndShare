//
//  AccountSettingsView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/15/21.
//

import SwiftUI

struct AccountSettingsView: View {
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Account Settings")
        }
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

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView()
    }
}
