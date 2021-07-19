//
//  CustomCalendar.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 7/13/21.
//

import Foundation
import SwiftDate

class CustomCalendarMonth: ObservableObject {

    // Variables
    @Published var arrayOfWeeksThenDays: [[CustomCalendarDay]]

    // Constants
    var monthName: String
    var yearName: String

    var firstDayOfMonth: Date

    var topLeftCornerDay: Date

    init(dateInTheMonth: Date) {
        arrayOfWeeksThenDays = [[CustomCalendarDay]]()

        let myCalendar = Calendar(identifier: .gregorian)

        self.firstDayOfMonth = dateInTheMonth.dateAt(.startOfMonth)
        let lastDayOfMonth: Int = myCalendar.component(.day, from: dateInTheMonth.dateAt(.endOfMonth))

        let startingInvalidDays: Double = Double(myCalendar.component(.weekday, from: firstDayOfMonth))

        self.topLeftCornerDay = firstDayOfMonth.addingTimeInterval(-60 * 60 * 24 * startingInvalidDays)

        self.monthName = Calendar.current.monthSymbols[myCalendar.component(.month, from: firstDayOfMonth) - 1]
        self.yearName = String(myCalendar.component(.year, from: firstDayOfMonth))

        /*print()
        print("firstDayOfMonth:     \(firstDayOfMonth.toString())")
        print("lastDayOfMonth:      \(lastDayOfMonth.toString())")
        print("startingInvalidDays: \(startingInvalidDays)")
        print("topLeftCornerDay:    \(topLeftCornerDay.toString())")
        print()*/

        // Create the calendar grid

        var gridIndex: Int = 0

        for weekOn in 1...6 {
            var singleWeek = [CustomCalendarDay]()
            for dayOn in 1...7 {
                gridIndex += 1
                let numDaysToAdd: Double = Double(((weekOn - 1) * 7) + dayOn - 1)

                if gridIndex < (Int(startingInvalidDays) + 2) {
                    singleWeek.append(CustomCalendarDay(dateOfDay: topLeftCornerDay.addingTimeInterval(60 * 60 * 24 * numDaysToAdd), selectable: false))
                } else if gridIndex > (lastDayOfMonth + (Int(startingInvalidDays) + 1)) {
                    singleWeek.append(CustomCalendarDay(dateOfDay: topLeftCornerDay.addingTimeInterval(60 * 60 * 24 * numDaysToAdd), selectable: false))
                } else {
                    singleWeek.append(CustomCalendarDay(dateOfDay: topLeftCornerDay.addingTimeInterval(60 * 60 * 24 * numDaysToAdd), selectable: true))
                }
            }
            arrayOfWeeksThenDays.append(singleWeek)
        }

    }

}
