//
//  HomeView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/17/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var user: FirebaseUserViewModel
    @State var selectedIndex = 2

    var body: some View {
        VStack {
            switch selectedIndex {
            case 0:
                DaySelectView()
            case 1:
                SurveyView()
            case 2:
                MainView()
            case 3:
                FeedbackView()
            case 4:
                AccountSettingsView()
            default:
                MainView()
            }
            VStack {
                Divider()
                HStack(alignment: .center, spacing: 16) {
                    Spacer()
                    Button(action: {
                        selectedIndex = 0
                    }, label: {
                        LinearGradient(gradient: Gradient(colors: [selectedIndex != 0 ? .red : .blue, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                            .frame(width: 50, height: 50, alignment: .center)
                            .mask(
                                Image(systemName: "calendar.badge.clock")
                                    .font(.title)
                            )
                            .frame(width: 50, height: 50, alignment: .leading)
                    })
                    Button(action: {
                        selectedIndex = 1
                    }, label: {
                        LinearGradient(gradient: Gradient(colors: [selectedIndex != 1 ? .red : .blue, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                            .frame(width: 50, height: 50, alignment: .center)
                            .mask(
                                Image(systemName: "doc.text.magnifyingglass")
                                    .font(.title)
                            )
                            .frame(width: 50, height: 50, alignment: .leading)
                    })
                    Button(action: {
                        selectedIndex = 2
                    }, label: {
                        LinearGradient(gradient: Gradient(colors: [selectedIndex != 2 ? .red : .blue, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                            .frame(width: 50, height: 50, alignment: .center)
                            .mask(
                                Image(systemName: "house.fill")
                                    .font(.largeTitle)
                            )
                            .frame(width: 50, height: 50, alignment: .leading)
                    })
                    Button(action: {
                        selectedIndex = 3
                    }, label: {
                        LinearGradient(gradient: Gradient(colors: [selectedIndex != 3 ? .red : .blue, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                            .frame(width: 50, height: 50, alignment: .center)
                            .mask(
                                Image(systemName: "text.bubble.fill")
                                    .font(.title)
                            )
                            .frame(width: 50, height: 50, alignment: .leading)
                    })
                    Button(action: {
                        selectedIndex = 4
                    }, label: {
                        LinearGradient(gradient: Gradient(colors: [selectedIndex != 4 ? .red : .blue, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                            .frame(width: 50, height: 50, alignment: .center)
                            .mask(
                                Image(systemName: "gearshape.fill")
                                    .font(.title)
                            )
                            .frame(width: 50, height: 50, alignment: .leading)
                    })
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(FirebaseUserViewModel())
    }
}
