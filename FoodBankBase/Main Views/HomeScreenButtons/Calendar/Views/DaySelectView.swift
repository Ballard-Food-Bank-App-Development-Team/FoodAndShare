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
    @StateObject var calendar = CustomCalendarYearViewModel()

    private let weekLetters: [String] = ["S", "M", "T", "W", "T", "F", "S"]

    // TODO: Change FoodBankStateCode to its own model
    @State private var foodBankState: String = ""
    private func updateHours() {
        for dayOn in 1...calendar.currentYear.activeMonth.lastDayOfMonth where calendar.currentYear.activeMonth.mutableArray[dayOn - 1].choosen {
            switch calendar.currentYear.activeMonth.mutableArray[dayOn - 1].dayOfWeek {
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

    var body: some View {
        VStack {
            // MARK: - Calendar Title
            HStack {

                Button(action: {
                    calendar.monthState -= 1
                    if calendar.monthState < 0 {
                        calendar.monthState = -1
                    }
                    calendar.changeActiveMonth()
                    foodBankState = ""
                    updateHours()
                }, label: {
                    Image(systemName: "arrowshape.turn.up.left")
                        .imageScale(.large)
                        .foregroundColor(Color("customOrange"))
                })

                Spacer()

                Text(calendar.currentYear.activeMonth.monthName + " " +  calendar.currentYear.activeMonth.yearName)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("customOrange"))

                Spacer()

                Button(action: {
                    calendar.monthState += 1
                    if calendar.monthState > 1 {
                        calendar.monthState = 1
                    }
                    calendar.changeActiveMonth()
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
                ForEach(calendar.currentYear.activeMonth.arrayOfWeeksThenDays, id: \.self) { week in
                    HStack {
                        ForEach(week, id: \.self) { day in
                            Group {
                                let dayOn = Calendar(identifier: .gregorian).component(.day , from: day.date) - 1
                                let selected: Bool = !(calendar.currentYear.activeMonth.mutableArray.count - 1 < dayOn) ? calendar.currentYear.activeMonth.mutableArray[dayOn].choosen : false

                                if day.selectable {
                                    Button(action: {
                                        calendar.refreshDaySelect(newDate: day)
                                        updateHours()
                                    }, label: {
                                        CalendarIcon(
                                            dayNum: day.dayNum,
                                            textColor: Color.white,
                                            circleColor: Color("customOrange"),
                                            outlineColor: selected ? Color("darkInvert") : Color.clear
                                        )
                                    })
                                } else if day.shown {
                                    Button(action: {
                                        calendar.refreshDaySelect(newDate: day)
                                        updateHours()
                                    }, label: {
                                        CalendarIcon(
                                            dayNum: day.dayNum,
                                            textColor: Color("darkInvert"),
                                            circleColor: Color(.systemBackground),
                                            outlineColor: selected ? Color("darkInvert") : Color.clear
                                        )
                                    })
                                } else {
                                    CalendarIcon(
                                        dayNum: day.dayNum,
                                        textColor: Color.white,
                                        circleColor: Color(.systemBackground),
                                        outlineColor: Color.clear
                                    )
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
