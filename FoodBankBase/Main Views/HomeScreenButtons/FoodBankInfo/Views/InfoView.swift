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
            Image("foodbankInfo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 260, height: 240,   alignment: .center)
                .frame(width: 340, height: 240)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: Color("customOrange"), radius: 5, y: 1)
            Text("About Us")
                .foregroundColor(Color("customOrange"))
                .font(.custom("HelveticaNeue-Medium", size: 24))
                .padding(.top)
            Text("Ballard Food Bank’s mission is to bring food and hope to our neighbors because there can be enough for everyone.")
                .foregroundColor(Color("navyBlue"))
                .font(.custom("HelveticaNeue-Medium", size: 18))
                .padding(.horizontal)
                .padding()
            Text("We provide access to nutritious food through our food bank, home delivery, and Weekend Food for Kids program. We also provide housing, medical care, and veterans’ benefits and access to utility assistance, identification vouchers, and our mail program. ")
                .foregroundColor(Color("navyBlue"))
                .font(.custom("HelveticaNeue-Medium", size: 18))
                .padding(.horizontal)
                .padding()

        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Info Page")
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

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
