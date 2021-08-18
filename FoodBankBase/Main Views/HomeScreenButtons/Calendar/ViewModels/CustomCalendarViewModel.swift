//
//  CustomCalendarViewModel.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/15/21.
//

import Foundation

class CustomCalendarViewModel: ObservableObject {
    private var currentMonth: CustomCalendarMonth
    private var previousMonth: CustomCalendarMonth
    private var nextMonth: CustomCalendarMonth

    @Published var activeMonth: CustomCalendarMonth
    @Published var monthState: Int

    func refreshDaySelect(dayNum: Int) {
        for dayOn in 0...30 where dayOn < self.activeMonth.lastDayOfMonth {
            self.activeMonth.arrayOfMonthDays[dayOn].choosen = false
        }
        self.activeMonth.arrayOfMonthDays[dayNum].choosen = true
    }

    func changeActiveMonth() {
        switch self.monthState {
        case -1:
            self.activeMonth = self.previousMonth
        case 0:
            self.activeMonth = self.currentMonth
        case 1:
            self.activeMonth = self.nextMonth
        default:
            self.activeMonth = self.currentMonth
        }
    }

    init() {
        self.currentMonth = CustomCalendarMonth(dateInTheMonth: Date())
        self.previousMonth = CustomCalendarMonth(dateInTheMonth: Date().dateAt(.startOfMonth).addingTimeInterval(-60 * 60 * 24))
        self.nextMonth = CustomCalendarMonth(dateInTheMonth: Date().dateAt(.endOfMonth).addingTimeInterval(60 * 60 * 24))

        self.activeMonth = self.currentMonth
        self.monthState = 0
    }
}
