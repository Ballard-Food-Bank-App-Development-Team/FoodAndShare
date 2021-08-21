//
//  CalendarIcon.swift
//  FoodBankBase
//
//  Created by Benjamin Roberts on 7/19/21.
//

import SwiftUI

struct CalendarIcon: View {

    var dayNum: String

    var textColor: Color
    var circleColor: Color
    var outlineColor: Color

    var body: some View {
        Text(dayNum)
            .font(.body)
            .foregroundColor(textColor)
            .frame(width: UIScreen.main.bounds.width / 9, height: UIScreen.main.bounds.width / 10, alignment: .center)
            .background(
                Circle()
                    .fill(circleColor)
                    .padding(.all, 2)
                    .background(
                        Circle()
                            .fill(outlineColor)
                    )
            )
    }
}

struct CalendarIcon_Previews: PreviewProvider {
    static var previews: some View {
        CalendarIcon(dayNum: "1", textColor: Color.white, circleColor: Color("customOrange"), outlineColor: Color.black)
    }
}
