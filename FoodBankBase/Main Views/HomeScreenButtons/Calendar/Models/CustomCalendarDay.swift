//
//  CustomCalendarDay.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 7/18/21.
//

import Foundation

struct CustomCalendarDay: Hashable {
    var date: Date
    var dayNum: Int
    var dayOfWeek: Int
    var selectable: Bool

    init(dateOfDay: Date, selectable: Bool) {
        self.date = dateOfDay
        self.selectable = selectable

        let myCalendar = Calendar(identifier: .gregorian)
        self.dayNum = myCalendar.component(.day , from: dateOfDay)
        self.dayOfWeek = myCalendar.component(.weekday, from: dateOfDay)

        // print("\(date.toString()) Successfully Created, DayOfWeek: \(self.dayOfWeek), selectable: \(self.selectable)")
    }
}
