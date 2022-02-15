//
//  privacyPolicyView.swift
//  FoodBankBase
//
//  Created by Benjamin Roberts on 9/5/21.
//
import WebKit
import SwiftUI

struct privacyPolicyView: View {
    @Environment(\.presentationMode) var presentation
    let url = URL(string: "https://sites.google.com/view/foodshare/privacy-policy")
    var body: some View {
        WebView(url: url)
    }
}

struct privacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        privacyPolicyView()
    }
}
