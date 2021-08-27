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
        // TODO: Connect to Ballard Food Bank Blog Page
        ScrollView {
            VStack {
                Image("newFoodBank")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.vertical)

                Spacer()

                Text("Ballard Food Bank is excited to work with Seattle-based architects Graham Baba to create our amazing new home, set to open in fall 2021.")
                    .foregroundColor(Color("navyBlue"))
                    .font(.custom("HelveticaNeue-Medium", size: 16))
                    .padding(.horizontal)

                Spacer()

                Text("The new design nearly doubles the size and capacity of the existing operation. Fundamental to the organization’s mission is the market, which is designed as a large supermarket style space.")
                    .foregroundColor(Color("navyBlue"))
                    .font(.custom("HelveticaNeue-Medium", size: 16))
                    .padding(.horizontal)

                Spacer()

                Text("Ballard Food Bank’s new home will be a true hub for hope in Northwest Seattle. We can’t wait to walk through the doors—and welcome the whole community—this coming fall.")
                    .foregroundColor(Color("navyBlue"))
                    .font(.custom("HelveticaNeue-Medium", size: 16))
                    .padding(.horizontal)

                Spacer()

                Link("Read More Stories", destination: URL(string: "https://www.ballardfoodbank.org/bfbblog")!)
                    .padding(.horizontal)

                Spacer()
            }
            .padding()
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
}

struct NewsUIView_Previews: PreviewProvider {
    static var previews: some View {
        NewsUIView()
    }
}
