//
//  BigButtonHomeScreenView.swift
//  FoodBankBase
//
//  Created by Benjamin Roberts on 8/15/21.
//

import SwiftUI

struct BigButtonHomeScreenView: View {

    var name: String
    var description: String
    var imageName: String
    var frame: CGFloat

    var body: some View {
        HStack {
            Spacer()
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: frame, height: frame, alignment: .center)
                .frame(width: 50, height: 50)
                .background(Color(.systemBackground))
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(name)
                    .foregroundColor(Color("navyBlue"))
                    .font(.custom("HelveticaNeue-Medium", size: 24))
                Text(description)// 19
                    .foregroundColor(Color("textGrey"))
                    .font(.custom("HelveticaNeue-Medium", size: 16))
            }
            Spacer()
            Image("orangePlus")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30, alignment: .center)
                .frame(width: 50, height: 50)
                .background(Color("spaceGrey"))
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - UIScreen.main.bounds.width / 4, height: 100, alignment: .center)
        .accentColor(.black)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("spaceGrey"))
                .shadow(color: Color("customOrange"), radius: 3)
        )
        .padding(.all, 5)
    }
}

struct BigButtonHomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        BigButtonHomeScreenView(name: "Test", description: "Test Description", imageName: "person", frame: 100)
    }
}
