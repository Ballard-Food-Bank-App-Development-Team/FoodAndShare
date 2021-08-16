//
//  ProfileIconView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/15/21.
//

import SwiftUI

struct ProfileIconView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.red, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
            .frame(width: 29, height: 29,   alignment: .center)
            .mask(
                Image(systemName: "person.fill")
                    .resizable()
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
            )
            .background(
                Circle()
                    .foregroundColor(Color("spaceGrey"))
                    .shadow(color: Color("customOrange"), radius: 5, y: 1)
            )
    }
}

struct ProfileIconView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileIconView()
    }
}
