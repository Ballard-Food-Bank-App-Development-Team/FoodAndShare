//
//  SelectDateView.swift
//  FoodBankBase
//
//  Created by Benjamin Roberts on 7/12/21.
//

import SwiftUI
import SwiftDate

struct SelectDateView: View {
    
    @StateObject var currentMonth: CustomCalendarMonth = CustomCalendarMonth(dateInTheMonth: Date())
    
    var body: some View {
        
        VStack {
            
            Text(currentMonth.arrayOfWeeksThenDays[0][0].dateOfDay.toString())
            Text(currentMonth.arrayOfWeeksThenDays[0][1].dateOfDay.toString())
            Text(currentMonth.arrayOfWeeksThenDays[0][2].dateOfDay.toString())
            Text(currentMonth.arrayOfWeeksThenDays[0][3].dateOfDay.toString())
            Text(currentMonth.arrayOfWeeksThenDays[0][4].dateOfDay.toString())
            Text(currentMonth.arrayOfWeeksThenDays[0][5].dateOfDay.toString())
            Text(currentMonth.arrayOfWeeksThenDays[0][6].dateOfDay.toString())
            Text(currentMonth.arrayOfWeeksThenDays[1][0].dateOfDay.toString())
            Text(currentMonth.arrayOfWeeksThenDays[1][1].dateOfDay.toString())
            
        }
        
    }
}

struct SelectDateView_Previews: PreviewProvider {
    static var previews: some View {
        SelectDateView()
    }
}
