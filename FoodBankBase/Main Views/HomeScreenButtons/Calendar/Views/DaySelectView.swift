//
//  DaySelectView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 7/10/21.
//

import SwiftUI
import SwiftDate

struct DaySelectView: View {
    @Environment(\.presentationMode) var presentation
    @StateObject var currentMonth = CustomCalendarMonth(date: Date())
    
    private let previousMonth: Date = Date().dateAt(.startOfMonth).addingTimeInterval(-60 * 60 * 24)
    private let nextMonth: Date = Date().dateAt(.endOfMonth).addingTimeInterval(60 * 60 * 24)
    
    @State private var calendarState: Int = 0

    private let weekLetters: [String] = ["S", "M", "T", "W", "T", "F", "S"]
    
    private func changeMonth() {
        
        if calendarState < 0 {
            currentMonth.updateMonth(dateInTheMonth: previousMonth)
        } else if calendarState > 0 {
            currentMonth.updateMonth(dateInTheMonth: nextMonth)
        } else {
            currentMonth.updateMonth(dateInTheMonth: Date())
        }
        
    }
    
    private func updateHours(dayOfWeek: Int) {
        
    }

    var body: some View {
        VStack {
            // MARK: - Calendar Title
            HStack {
                
                Button(action: {
                    calendarState -= 1
                    if calendarState < 0 {
                        calendarState = -1
                    }
                    changeMonth()
                }, label: {
                    Image(systemName: "arrowshape.turn.up.left")
                        .imageScale(.large)
                        .foregroundColor(Color("customOrange"))
                })
                
                Spacer()
                
                Text(currentMonth.monthName! + " " +  currentMonth.yearName!)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("customOrange"))
                
                Spacer()
                    
                Button(action: {
                    calendarState += 1
                    if calendarState > 1 {
                        calendarState = 1
                    }
                    changeMonth()
                }, label: {
                    Image(systemName: "arrowshape.turn.up.right")
                        .imageScale(.large)
                        .foregroundColor(Color("customOrange"))
                })
                
            }
            .padding(.all)
            
            // MARK: - Week Letters
            HStack {
                ForEach(weekLetters, id: \.self) { letter in
                    Text(letter)
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(Color.gray)
                        .frame(width: UIScreen.main.bounds.width/9, alignment: .center)
                }
            }

            Divider()

            VStack {
                ForEach(currentMonth.arrayOfWeeksThenDays!, id: \.self) { week in
                    HStack {
                        ForEach(week, id: \.self) { day in
                            Group {
                                if day.selectable {
                                    Button(action: {
                                        currentMonth.arrayOfWeeksThenDays!.remove(at: week)
                                        updateHours(day: day.dayOfWeek)
                                    }, label: {
                                        CalendarIcon(dayNum: day.dayNum, textColor: Color.white, circleColor: Color("customOrange"))
                                    })
                                } else if day.shown {
                                    CalendarIcon(dayNum: day.dayNum, textColor: Color("darkInvert"), circleColor: Color(.systemBackground))
                                } else {
                                    CalendarIcon(dayNum: day.dayNum, textColor: Color.white, circleColor: Color(.systemBackground))
                                }
                            }
                        }
                    }
                    .padding(.all, 0.5)
                }
            }
            .padding(.all, 8.0)
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Day Selection")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: { presentation.wrappedValue.dismiss()
            }
            , label: {
                Image(systemName: "arrow.backward")
                    .imageScale(.large)
                    .accentColor(Color("darkInvert"))
            })
        )
    }
}

struct DaySelectView_Previews: PreviewProvider {
    static var previews: some View {
        DaySelectView()

    }
}
