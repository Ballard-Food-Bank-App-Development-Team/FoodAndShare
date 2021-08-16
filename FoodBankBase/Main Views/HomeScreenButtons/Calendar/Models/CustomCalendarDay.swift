//
//  CustomCalendarDay.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 7/18/21.
//

import Foundation

struct CustomCalendarDay: Hashable {
    var date: Date
    var dayNum: String
    var dayOfWeek: Int

    var choosen: Bool

    init(dateOfDay: Date) {
        self.date = dateOfDay
        self.choosen = false

        let myCalendar = Calendar(identifier: .gregorian)
        self.dayNum = String(myCalendar.component(.day , from: dateOfDay.addingTimeInterval(60 * 60 * 24)))
        let dayOfWeekTemp = myCalendar.component(.weekday, from: dateOfDay) + 1
        self.dayOfWeek = (dayOfWeekTemp == 8) ? 1 : dayOfWeekTemp

        // print("Date: \(date.toString()) \n DayOfWeek: \(dayOfWeek)")
        // print("\(date.toString()) Successfully Created, DayOfWeek: \(self.dayOfWeek), selectable: \(self.selectable)")
    }
}
