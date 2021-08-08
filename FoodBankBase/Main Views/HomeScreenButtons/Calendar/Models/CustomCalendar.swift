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

    @Published var mutableArray: [CustomCalendarDay]?

    @Published var monthName: String?
    @Published var yearName: String?

    @Published var firstDayOfMonth: Date?
    @Published var lastDayOfMonth: Int?

    @Published var topLeftCornerDay: Date?
    @Published var startingInvalidDays: Double?

    func refreshDaySelect(newDate: CustomCalendarDay) {
        for dayOn in 1...lastDayOfMonth! {
            mutableArray![dayOn - 1].choosen = false
        }
        mutableArray![Calendar(identifier: .gregorian).component(.day , from: newDate.date) - 1].choosen = true
    }

    func updateMonth(dateInTheMonth: Date) {
        arrayOfWeeksThenDays = [[CustomCalendarDay]]()
        mutableArray = [CustomCalendarDay]()

        let myCalendar = Calendar(identifier: .gregorian)

        self.firstDayOfMonth = dateInTheMonth.dateAt(.startOfMonth)
        self.lastDayOfMonth = myCalendar.component(.day, from: dateInTheMonth.dateAt(.endOfMonth))

        self.startingInvalidDays = Double(myCalendar.component(.weekday, from: self.firstDayOfMonth!))

        self.topLeftCornerDay = self.firstDayOfMonth!.addingTimeInterval(-60 * 60 * 24 * startingInvalidDays!)

        self.monthName = Calendar.current.monthSymbols[myCalendar.component(.month, from: self.firstDayOfMonth!) - 1]
        self.yearName = String(myCalendar.component(.year, from: self.firstDayOfMonth!))

        var gridIndex: Int = 0

        for weekOn in 1...6 {
            var singleWeek = [CustomCalendarDay]()
            var firstAdded: Bool = false
            for dayOn in 1...7 {
                gridIndex += 1
                let numDaysToAdd: Double = Double(((weekOn - 1) * 7) + dayOn - 1)
                let curDate: Date = self.topLeftCornerDay!.addingTimeInterval(60 * 60 * 24 * numDaysToAdd)

                let curDateDay: Int = myCalendar.component(.day, from: curDate)
                let curDateMonth: Int = myCalendar.component(.month, from: curDate)
                let todayDay: Int = myCalendar.component(.day, from: Date())
                let todayMonth: Int = myCalendar.component(.month, from: Date())

                if gridIndex < (Int(startingInvalidDays!) + 2) {
                    singleWeek.append(CustomCalendarDay(dateOfDay: curDate, selectable: false, shown: false))
                } else if gridIndex > (lastDayOfMonth! + (Int(startingInvalidDays!) + 1)) {
                    singleWeek.append(CustomCalendarDay(dateOfDay: curDate, selectable: false, shown: false))
                } else if dayOn == 1 || dayOn == 6 || dayOn == 7 {
                    singleWeek.append(CustomCalendarDay(dateOfDay: curDate, selectable: false, shown: true))
                    mutableArray!.append(CustomCalendarDay(dateOfDay: curDate, selectable: false, shown: true))
                    if !firstAdded && curDateDay == todayDay && curDateMonth == todayMonth {
                        mutableArray![todayDay - 1].choosen = true
                        firstAdded = true
                    }
                } else {
                    singleWeek.append(CustomCalendarDay(dateOfDay: curDate, selectable: true, shown: false))
                    mutableArray!.append(CustomCalendarDay(dateOfDay: curDate, selectable: true, shown: false))
                    if !firstAdded && curDateDay == todayDay && curDateMonth == todayMonth {
                        mutableArray![todayDay - 1].choosen = true
                        firstAdded = true
                    }
                }
            }
            arrayOfWeeksThenDays!.append(singleWeek)
        }
    }

    init(date: Date) {
        updateMonth(dateInTheMonth: date)
    }
}
