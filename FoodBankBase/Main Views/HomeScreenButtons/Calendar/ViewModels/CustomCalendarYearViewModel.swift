//
//  CustomCalendarYearViewModel.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/14/21.
//

import Foundation

class CustomCalendarYearViewModel: ObservableObject {

    @Published var currentYear = CustomCalendarYear(dateInTheMonth: Date())

    @Published var monthState: Int = 0

    func changeActiveMonth() {
        if monthState < 0 {
            currentYear.activeMonth = currentYear.previosMonth
        } else if monthState > 0 {
            currentYear.activeMonth = currentYear.nextMonth
        } else {
            currentYear.activeMonth = currentYear.currentMonth
        }
    }

    func refreshDaySelect(newDate: CustomCalendarDay) {
        for dayOn in 1...currentYear.activeMonth.lastDayOfMonth {
            currentYear.activeMonth.mutableArray[dayOn - 1].choosen = false
        }
        currentYear.activeMonth.mutableArray[Calendar(identifier: .gregorian).component(.day , from: newDate.date) - 1].choosen = true
    }
}
