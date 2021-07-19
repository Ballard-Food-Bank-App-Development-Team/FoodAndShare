//
//  DaySelectView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 7/10/21.
//

import SwiftUI

struct DaySelectView: View {
    @Environment(\.presentationMode) var presentation
    @StateObject var currentMonth = CustomCalendarMonth(dateInTheMonth: Date())

    let weekLetters: [String] = ["S", "M", "T", "W", "T", "F", "S"]

    var body: some View {
        VStack {
            HStack {
                Text(currentMonth.monthName + " " +  currentMonth.yearName)
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding()

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
                ForEach(currentMonth.arrayOfWeeksThenDays, id: \.self) { week in
                    HStack {
                        ForEach(week, id: \.self) { day in
                            Group {
                                if day.selectable {
                                    NavigationLink(
                                        destination: HourSelectView(day: day),
                                        label: {
                                            Text("\(day.dayNum)")
                                                .font(.body)
                                                .foregroundColor(Color.white)
                                                .frame(width: UIScreen.main.bounds.width/9, height: UIScreen.main.bounds.width/10, alignment: .center)
                                                .background(
                                                    Circle()
                                                        .fill(Color("navy"))
                                                )
                                        })
                                } else {
                                    Text("\(day.dayNum)")
                                        .font(.body)
                                        .foregroundColor(Color.gray)
                                        .frame(width: UIScreen.main.bounds.width/9, height: UIScreen.main.bounds.width/10, alignment: .center)
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
                    .accentColor(Color.white)
            })
        )
    }
}

struct DaySelectView_Previews: PreviewProvider {
    static var previews: some View {
        DaySelectView()

    }
}
