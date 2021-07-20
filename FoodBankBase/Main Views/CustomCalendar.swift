//
//  CustomCalendar.swift
//  FoodBankBase
//
//  Created by Benjamin Roberts on 7/12/21.
//

import Foundation
import SwiftDate

class CustomCalendarMonth: ObservableObject {

    // Variables

    @Published var arrayOfWeeksThenDays: [[CustomCalendarDay]]

    // Constants

    var firstDayOfMonth: CustomCalendarDay
    var lastDayOfMonth: CustomCalendarDay

    var lastDayOfPreviousMonth: Date

    var gridIndexOnlastDayOfMonth: Int

    init(dateInTheMonth: Date) {
        
        arrayOfWeeksThenDays = [[CustomCalendarDay]]()
        
        self.firstDayOfMonth = CustomCalendarDay(dateOfDay: dateInTheMonth.dateAt(.startOfMonth), selectable: true)
        self.lastDayOfMonth = CustomCalendarDay(dateOfDay: dateInTheMonth.dateAt(.endOfMonth), selectable: true)
        self.lastDayOfPreviousMonth = firstDayOfMonth.dateOfDay.addingTimeInterval(-7 * 24 * 60 * 60).dateAt(.endOfMonth)
        
        
        let date1 = self.firstDayOfMonth.dateOfDay
        let date2 = self.lastDayOfMonth.dateOfDay
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.day], from: date1)
        let day1 = components1.day
        let components2 = calendar.dateComponents([.day], from: date1)
        let day2 = components2.day
        
        self.gridIndexOnlastDayOfMonth = day1! - 1 + day2!

        var gridIndex: Int = 0

        func getCurrentDayNumber() -> Int {
            return (gridIndex - self.firstDayOfMonth.dayOfTheWeek) + 1
        }

        // Create the calendar grid
        for weekOn in 1...6 {
            var singleWeek = [CustomCalendarDay]()

            for dayOn in 1...7 {

                gridIndex += 1

                if gridIndex - firstDayOfMonth.dayOfTheWeek < 0 {
                    
                    let date = lastDayOfPreviousMonth
                    let calendar = Calendar.current
                    let components = calendar.dateComponents([.day], from: date)
                    let lastDayMonth = components.day
                    
                    
                    singleWeek.append(CustomCalendarDay(dateOfDay: Date() /* Day Component that takes lastDayOfPreviousMonth.day - firstDayOfMonth.DateOfWeek and add 1 and add gridIndex and create a date based on that number and that lastDayOfPreviousMonth.month */, selectable: false))

                    continue

                } else if gridIndexOnlastDayOfMonth < gridIndex {

                    singleWeek.append(CustomCalendarDay(dateOfDay: Date() /* Day Component add gridIndex - gridIndexOnlastDayOfMonth to lastDayOfMonth.DateOfDay */, selectable: false))
                    
                    continue

                } else {

                    if dayOn == 1 || dayOn == 7 {

                        singleWeek.append(CustomCalendarDay(dateOfDay: Date() /* getCurrentDayNumber() and create a Date */, selectable: false))

                    } else {

                        singleWeek.append(CustomCalendarDay(dateOfDay: Date() /* getCurrentDayNumber() and create a Date */, selectable: true))

                    }

                }

            }

            // Change these checks to throw errors

            if singleWeek.count != 7 {
                print("There must be seven days in a week")
            }
            
            arrayOfWeeksThenDays.append(singleWeek)
        }

    }

}


class CustomCalendarDay {

    var dateOfDay: Date
    var dayOfTheWeek: Int
    var selectable: Bool

    init(dateOfDay: Date, selectable: Bool) {
        self.dateOfDay = dateOfDay
        
        let myCalendar = Calendar(identifier: .gregorian)
        self.dayOfTheWeek = myCalendar.component(.weekday, from: dateOfDay)
    
        self.selectable = selectable
    }

}
