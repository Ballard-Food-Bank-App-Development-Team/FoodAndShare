//
//  CalendarView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 7/1/21.
//

import SwiftUI
import ElegantCalendar

struct CalendarView: View {

    @ObservedObject var calendarManager = MonthlyCalendarManager(
        configuration: CalendarConfiguration(startDate: Date.init(), endDate: Date.distantFuture))

    var body: some View {
        MonthlyCalendarView(calendarManager: calendarManager)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
