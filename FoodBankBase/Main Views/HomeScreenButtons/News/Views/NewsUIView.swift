//
//  NewsUIView.swift
//  FoodBankBase
//
//  Created by Benjamin Roberts on 8/8/21.
//

import SwiftUI

struct NewsUIView: View {
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack {
            WebView(url: URL(string: "https://www.ballardfoodbank.org/blog"))
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("News")
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

struct NewsUIView_Previews: PreviewProvider {
    static var previews: some View {
        NewsUIView()
    }
}
