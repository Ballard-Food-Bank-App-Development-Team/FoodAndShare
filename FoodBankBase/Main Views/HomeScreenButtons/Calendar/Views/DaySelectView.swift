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

    @State private var foodBankState: String = ""

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

    private func updateHours() {
        for dayOn in 1...currentMonth.lastDayOfMonth! {
            if currentMonth.mutableArray![dayOn - 1].choosen {
                switch currentMonth.mutableArray![dayOn - 1].dayOfWeek + 1 {
                case 1:
                    foodBankState = "Closed"
                case 2:
                    foodBankState = "2pm - 6pm"
                case 3:
                    foodBankState = "11am - 4pm"
                case 4:
                    foodBankState = "12pm - 4pm"
                case 5:
                    foodBankState = "2pm - 6pm"
                case 6:
                    foodBankState = "Closed"
                case 7:
                    foodBankState = "Closed"
                default:
                    foodBankState = "Closed"
                }
            }
        }
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
                    foodBankState = ""
                    updateHours()
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
                    foodBankState = ""
                    updateHours()
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
                                let dayOn = Calendar(identifier: .gregorian).component(.day , from: day.date) - 1
                                let selected: Bool = !(currentMonth.mutableArray!.count - 1 < dayOn) ? currentMonth.mutableArray![dayOn].choosen : false

                                if day.selectable {
                                    Button(action: {
                                        currentMonth.refreshDaySelect(newDate: day)
                                        updateHours()
                                    }, label: {
                                        CalendarIcon(dayNum: day.dayNum, textColor: Color.white, circleColor: Color("customOrange"), outlineColor: selected ? Color("darkInvert") : Color.clear)
                                    })
                                } else if day.shown {
                                    Button(action: {
                                        currentMonth.refreshDaySelect(newDate: day)
                                        updateHours()
                                    }, label: {
                                        CalendarIcon(dayNum: day.dayNum, textColor: Color("darkInvert"), circleColor: Color(.systemBackground), outlineColor: selected ? Color("darkInvert") : Color.clear)
                                    })
                                } else {
                                    CalendarIcon(dayNum: day.dayNum, textColor: Color.white, circleColor: Color(.systemBackground), outlineColor: Color.clear)
                                }
                            }
                        }
                    }
                    .padding(.all, 0.5)
                }
            }
            .padding(.all, 8.0)
            Spacer()

            Text(foodBankState)
                .font(.largeTitle)

            Spacer()
        }
        .onAppear {
            updateHours()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Calendar")
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
