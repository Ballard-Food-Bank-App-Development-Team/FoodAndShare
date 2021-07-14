//
//  DaySelectView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 7/10/21.
//

import SwiftUI

struct DaySelectView: View {

    @StateObject var currentMonth = CustomCalendarMonth(dateInTheMonth: Date())

    var body: some View {
        ZStack {

            Text(currentMonth.arrayOfWeeksThenDays[0][0].date.toString())
            Text(currentMonth.arrayOfWeeksThenDays[0][1].date.toString())
            Text(currentMonth.arrayOfWeeksThenDays[0][2].date.toString())
            Text(currentMonth.arrayOfWeeksThenDays[0][3].date.toString())
            Text(currentMonth.arrayOfWeeksThenDays[0][4].date.toString())
            Text(currentMonth.arrayOfWeeksThenDays[0][5].date.toString())
            Text(currentMonth.arrayOfWeeksThenDays[0][6].date.toString())
            Text(currentMonth.arrayOfWeeksThenDays[1][0].date.toString())
            Text(currentMonth.arrayOfWeeksThenDays[1][1].date.toString())

        }
    }
}

struct DaySelectView_Previews: PreviewProvider {
    static var previews: some View {
        DaySelectView()
    }
}
