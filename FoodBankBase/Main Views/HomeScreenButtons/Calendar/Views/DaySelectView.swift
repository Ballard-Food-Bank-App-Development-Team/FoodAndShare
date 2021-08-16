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
    @StateObject var calendar = CustomCalendarViewModel()

    private let weekLetters: [String] = ["S", "M", "T", "W", "T", "F", "S"]

    // TODO: Change FoodBankStateCode to its own model
    @State private var foodBankState: String = ""
    private func updateHours() {
        for dayOn in 1...self.calendar.activeMonth.arrayOfMonthDays.count where self.calendar.activeMonth.arrayOfMonthDays[dayOn - 1].choosen == true {
            switch self.calendar.activeMonth.arrayOfMonthDays[dayOn - 1].dayOfWeek {
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
                    if calendar.monthState == 0 || calendar.monthState == 1 {
                        calendar.monthState -= 1
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

                Text("\(calendar.activeMonth.monthName) \(calendar.activeMonth.yearName)")
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
                ForEach([1, 2, 3, 4, 5, 6], id: \.self) { weekOn in
                    HStack {
                        ForEach([1, 2, 3, 4, 5, 6, 7], id: \.self) { dayOn in
                            let gridIndex: Int = ((weekOn - 1) * 7) + dayOn - 1
                            let invalidDays: Int = Int(self.calendar.activeMonth.startingInvalidDays)

                            if gridIndex < invalidDays || (gridIndex - invalidDays) >= self.calendar.activeMonth.lastDayOfMonth {
                                CalendarIcon(
                                    dayNum: "",
                                    textColor: Color.white,
                                    circleColor: Color(.systemBackground),
                                    outlineColor: Color.clear
                                )
                            } else if dayOn == 1 || dayOn == 6 || dayOn == 7 {
                                Button(action: {
                                    calendar.refreshDaySelect(dayNum: gridIndex - invalidDays)
                                    updateHours()
                                }, label: {
                                    CalendarIcon(
                                        dayNum: String(gridIndex - invalidDays + 1),
                                        textColor: Color("darkInvert"),
                                        circleColor: Color(.systemBackground),
                                        outlineColor: self.calendar.activeMonth.arrayOfMonthDays[gridIndex - invalidDays].choosen ? Color("darkInvert") : Color.clear
                                    )
                                })
                            } else {
                                Button(action: {
                                    calendar.refreshDaySelect(dayNum: gridIndex - invalidDays)
                                    updateHours()
                                }, label: {
                                    CalendarIcon(
                                        dayNum: String(gridIndex - invalidDays + 1),
                                        textColor: Color.white,
                                        circleColor: Color("customOrange"),
                                        outlineColor: self.calendar.activeMonth.arrayOfMonthDays[gridIndex - invalidDays].choosen ? Color("darkInvert") : Color.clear
                                    )
                                })
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
