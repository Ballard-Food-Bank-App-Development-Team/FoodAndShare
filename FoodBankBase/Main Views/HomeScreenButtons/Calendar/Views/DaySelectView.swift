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
    @State private var eventList: String = ""
    let masterList = ["Drive Through (2 - 6)", "Mail", "No Cook Bags", "Sandwiches at Door", "ID Assistance (12 - 4)", "Home Delivery", "Drive Through (12 - 4)"]
    private func updateEvents() {
        for dayOn in 1...self.calendar.activeMonth.arrayOfMonthDays.count where self.calendar.activeMonth.arrayOfMonthDays[dayOn - 1].choosen == true {
            switch self.calendar.activeMonth.arrayOfMonthDays[dayOn - 1].dayOfWeek {
            case 1:
                eventList = ""
            case 2:
                eventList = masterList[0] + "\n" + masterList[1] + "\n" + masterList[2] + "\n" + masterList[3]
            case 3:
                eventList = masterList[1] + "\n" + masterList[2] + "\n" + masterList[3] + "\n" + masterList[4] + "\n" + masterList[5]
            case 4:
                eventList = masterList[6] + "\n" + masterList[1] + "\n" + masterList[2] + "\n" + masterList[3] + "\n" + masterList[5]
            case 5:
                eventList = masterList[0] + "\n" + masterList[1] + "\n" + masterList[2] + "\n" + masterList[3] + "\n" + masterList[5]
            case 6:
                eventList = ""
            case 7:
                eventList = ""
            default:
                eventList = ""
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
                    eventList = ""
                    updateHours()
                    updateEvents()
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
                    eventList = ""
                    updateHours()
                    updateEvents()
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
                        .frame(width: UIScreen.main.bounds.width / 9, alignment: .center)
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
                                    updateEvents()
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
                                    updateEvents()
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
            VStack(alignment: .center) {
                Text(foodBankState)
                    .font(.largeTitle)
                Divider()
                Text(eventList)
                    .font(.headline)
                    .foregroundColor(Color("textGrey"))
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .lineSpacing(20)
                    .padding(.all, 10)
                Spacer()
            }
        }
        .onAppear {
            updateHours()
            updateEvents()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Calendar")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: { presentation.wrappedValue.dismiss()
            }, label: {
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
