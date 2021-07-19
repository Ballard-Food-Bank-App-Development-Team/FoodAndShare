//
//  HourSelectView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 7/18/21.
//

import SwiftUI

struct HourSelectView: View {
    @Environment(\.presentationMode) var presentation
    var day: CustomCalendarDay

    var body: some View {
        VStack {
            Text("\(day.dayNum)")
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Hour Selection")
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

struct HourSelectView_Previews: PreviewProvider {
    static var previews: some View {
        HourSelectView(day: CustomCalendarDay(dateOfDay: Date(), selectable: true))
    }
}
