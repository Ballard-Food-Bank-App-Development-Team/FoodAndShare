//
//  InfoView.swift
//  FoodBankBase
//
//  Created by Benjamin Roberts on 8/7/21.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack {
            WebView(url: URL(string: "https://www.ballardfoodbank.org/about-us"))
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Info Page")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: { presentation.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "arrow.backward")
                    .imageScale(.large)
                    .accentColor(Color("darkInvert"))
            })
        )
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
