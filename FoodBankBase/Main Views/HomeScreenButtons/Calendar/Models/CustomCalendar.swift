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
    @Published var arrayOfWeeksThenDays: [[CustomCalendarDay]]?
    
    @Published var monthName: String?
    @Published var yearName: String?

    @Published var firstDayOfMonth: Date?

    @Published var topLeftCornerDay: Date?

    func updateMonth(dateInTheMonth: Date) {
        arrayOfWeeksThenDays = [[CustomCalendarDay]]()

        let myCalendar = Calendar(identifier: .gregorian)

        self.firstDayOfMonth = dateInTheMonth.dateAt(.startOfMonth)
        let lastDayOfMonth: Int = myCalendar.component(.day, from: dateInTheMonth.dateAt(.endOfMonth))

        let startingInvalidDays: Double = Double(myCalendar.component(.weekday, from: self.firstDayOfMonth!))

        self.topLeftCornerDay = self.firstDayOfMonth!.addingTimeInterval(-60 * 60 * 24 * startingInvalidDays)

        self.monthName = Calendar.current.monthSymbols[myCalendar.component(.month, from: self.firstDayOfMonth!) - 1]
        self.yearName = String(myCalendar.component(.year, from: self.firstDayOfMonth!))

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
                    singleWeek.append(CustomCalendarDay(dateOfDay: self.topLeftCornerDay!.addingTimeInterval(60 * 60 * 24 * numDaysToAdd), selectable: false, shown: false))
                } else if gridIndex > (lastDayOfMonth + (Int(startingInvalidDays) + 1)) {
                    singleWeek.append(CustomCalendarDay(dateOfDay: self.topLeftCornerDay!.addingTimeInterval(60 * 60 * 24 * numDaysToAdd), selectable: false, shown: false))
                } else if dayOn == 1 || dayOn == 6 || dayOn == 7 {
                    singleWeek.append(CustomCalendarDay(dateOfDay: self.topLeftCornerDay!.addingTimeInterval(60 * 60 * 24 * numDaysToAdd), selectable: false, shown: true))
                } else {
                    singleWeek.append(CustomCalendarDay(dateOfDay: self.topLeftCornerDay!.addingTimeInterval(60 * 60 * 24 * numDaysToAdd), selectable: true, shown: false))
                }
            }
            arrayOfWeeksThenDays!.append(singleWeek)
        }

    }
    
    init(date: Date) {
        updateMonth(dateInTheMonth: date)
    }
}
