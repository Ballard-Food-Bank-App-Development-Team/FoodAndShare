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
    var firstDayOfMonth: CustomCalendarDay
    var lastDayOfMonth: CustomCalendarDay

    var lastDayOfPreviousMonth: Date

    var gridIndexOnlastDayOfMonth: Int

    init(dateInTheMonth: Date) {

        func dateDayToInt(date: Date) -> Int {
            return Calendar.current.dateComponents([.day], from: date).day!
        }

        func intDayToDate(day: Int, targetDateRegion: Date) -> Date {

            let year: Int = Calendar.current.dateComponents([.year], from: targetDateRegion).year!
            let month: Int = Calendar.current.dateComponents([.month], from: targetDateRegion).month!

            let monthAsString: String = month < 10 ? "0\(month)" : String(month)
            let dayAsString: String = day < 10 ? "0\(day)" : String(day)

            let stringDate = "\(year)-\(monthAsString)-\(dayAsString)"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: stringDate)

            return date!
        }

        func getCurrentDayNumber() -> Int {
            return (gridIndex - self.firstDayOfMonth.dayOfWeek) + 1
        }

        arrayOfWeeksThenDays = [[CustomCalendarDay]]()

        self.firstDayOfMonth = CustomCalendarDay(dateOfDay: dateInTheMonth.dateAt(.startOfMonth), selectable: true)
        self.lastDayOfMonth = CustomCalendarDay(dateOfDay: dateInTheMonth.dateAt(.endOfMonth), selectable: true)
        self.lastDayOfPreviousMonth = date!.dateAt(.endOfMonth)

        self.gridIndexOnlastDayOfMonth = dateDayToInt(date: self.firstDayOfMonth.date) + dateDayToInt(date: self.lastDayOfMonth.date) - 1

        var gridIndex: Int = 0

        // Create the calendar grid
        for _ in 1...6 {
            var singleWeek = [CustomCalendarDay]()

            for dayOn in 1...7 {

                gridIndex += 1

                if gridIndex - firstDayOfMonth.dayOfWeek < 0 {

                    print()
                    print("lastDayofPreviousMonth: \(lastDayOfPreviousMonth.date.toString())")
                    print("firstDayofMonth: \(firstDayOfMonth.dayOfWeek)")
                    print("gridIndex: \(gridIndex)")

                    let dateDayNumber: Int = dateDayToInt(date:lastDayOfPreviousMonth.date) - firstDayOfMonth.dayOfWeek + gridIndex + 1

                    print("dateDayNumber: \(dateDayNumber)")

                    singleWeek.append(CustomCalendarDay(dateOfDay: intDayToDate(day: dateDayNumber, targetDateRegion: lastDayOfPreviousMonth.date), selectable: false))

                    continue

                } else if gridIndexOnlastDayOfMonth < gridIndex {

                    let dateDayNumber: Int = (gridIndex - gridIndexOnlastDayOfMonth) + dateDayToInt(date: lastDayOfMonth.date)
                    let dateInNextMonth: Date = lastDayOfMonth.date.addingTimeInterval(7 * 24 * 60 * 60)

                    singleWeek.append(CustomCalendarDay(dateOfDay: intDayToDate(day: dateDayNumber, targetDateRegion: dateInNextMonth), selectable: false))

                    continue

                } else {

                    if dayOn == 1 || dayOn == 7 {

                        singleWeek.append(CustomCalendarDay(dateOfDay: intDayToDate(day: getCurrentDayNumber(), targetDateRegion: firstDayOfMonth.date), selectable: false))

                    } else {

                        singleWeek.append(CustomCalendarDay(dateOfDay: intDayToDate(day: getCurrentDayNumber(), targetDateRegion: firstDayOfMonth.date), selectable: true))

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

    var date: Date
    var dayOfWeek: Int
    var selectable: Bool

    init(dateOfDay: Date, selectable: Bool) {
        self.date = dateOfDay

        let myCalendar = Calendar(identifier: .gregorian)
        self.dayOfWeek = myCalendar.component(.weekday, from: dateOfDay)

        self.selectable = selectable

        print("\(date.toString()) Successfully Created, DayOfWeek: \(dayOfWeek), selectable: \(selectable)")
    }

}
