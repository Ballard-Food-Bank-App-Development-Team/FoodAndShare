//
//  CustomCalendarYear.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/14/21.
//

import Foundation

class CustomCalendarYear: ObservableObject {
    var currentMonth: CustomCalendarMonth
    var previosMonth: CustomCalendarMonth
    var nextMonth: CustomCalendarMonth

    var activeMonth: CustomCalendarMonth

    init(dateInTheMonth: Date) {
        self.currentMonth = CustomCalendarMonth(dateInTheMonth: Date())
        self.previosMonth = CustomCalendarMonth(dateInTheMonth: Date().dateAt(.startOfMonth).addingTimeInterval(-60 * 60 * 24))
        self.nextMonth = CustomCalendarMonth(dateInTheMonth: Date().dateAt(.endOfMonth).addingTimeInterval(60 * 60 * 24))

        self.activeMonth = self.currentMonth
    }
}
