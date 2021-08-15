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
    var selectable: Bool
    var shown: Bool
    var choosen: Bool

    init(dateOfDay: Date, selectable: Bool, shown: Bool) {
        self.date = dateOfDay
        self.selectable = selectable
        self.shown = shown
        self.choosen = false

        let myCalendar = Calendar(identifier: .gregorian)
        if shown || selectable {
            self.dayNum = String(myCalendar.component(.day , from: dateOfDay))
        } else {
            dayNum = ""
        }
        self.dayOfWeek = myCalendar.component(.weekday, from: dateOfDay)

        // print("\(date.toString()) Successfully Created, DayOfWeek: \(self.dayOfWeek), selectable: \(self.selectable)")
    }
}
