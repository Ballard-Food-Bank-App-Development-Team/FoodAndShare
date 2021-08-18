//
//  CustomCalendar.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 7/13/21.
//

import Foundation
import SwiftDate

struct CustomCalendarMonth {

    // Variables
    var arrayOfMonthDays: [CustomCalendarDay]

    let monthName: String
    let yearName: String

    let firstDayOfMonth: Date
    let lastDayOfMonth: Int

    let startingInvalidDays: Double
    let topLeftCornerDay: Date

    init(dateInTheMonth: Date) {
        let myCalendar = Calendar(identifier: .gregorian)

        self.arrayOfMonthDays = [CustomCalendarDay]()

        self.firstDayOfMonth = dateInTheMonth.dateAt(.startOfMonth)
        self.lastDayOfMonth = myCalendar.component(.day, from: dateInTheMonth.dateAt(.endOfMonth))

        let startingInvalidDaysTemp = myCalendar.component(.weekday, from: self.firstDayOfMonth) + 1
        self.startingInvalidDays = Double(startingInvalidDaysTemp == 8 ? 1 : startingInvalidDaysTemp) - 1.0

        self.topLeftCornerDay = self.firstDayOfMonth.addingTimeInterval(-60 * 60 * 24 * startingInvalidDays)

        self.monthName = Calendar.current.monthSymbols[myCalendar.component(.month, from: firstDayOfMonth)]
        self.yearName = String(myCalendar.component(.year, from: firstDayOfMonth))

        for dayOn in 0...30 where dayOn < self.lastDayOfMonth {
            let date = self.firstDayOfMonth.addingTimeInterval(60 * 60 * 24 * Double(dayOn))

            self.arrayOfMonthDays.append(CustomCalendarDay(dateOfDay: date))

            let dateDay = myCalendar.component(.day, from: date)
            let dateMonth = myCalendar.component(.month, from: date)

            let curDay = myCalendar.component(.day, from: Date())
            let curMonth = myCalendar.component(.month, from: Date())

            if dateDay == curDay && dateMonth == curMonth {
                self.arrayOfMonthDays[dayOn].choosen = true
            }
        }
    }
}
