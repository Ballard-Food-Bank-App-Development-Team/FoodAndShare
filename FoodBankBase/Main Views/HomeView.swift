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
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 16) {
                        Spacer()
                        Button(action: {
                            selectedIndex = 0
                        }, label: {
                            if(selectedIndex == 0) {
                                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                                .frame(width: 50, height: 50, alignment: .center)
                                .mask(
                                    Image(systemName: "calendar.badge.clock")
                                        .font(.title)
                                )
                                .frame(width: 50, height: 50, alignment: .leading)
                            }
                            else if(selectedIndex != 0) {
                                LinearGradient(gradient: Gradient(colors: [.red, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                                .frame(width: 50, height: 50, alignment: .center)
                                .mask(
                                    Image(systemName: "calendar.badge.clock")
                                        .font(.title)
                                )
                                .frame(width: 50, height: 50, alignment: .leading)
                            }
                        })
                        Button(action: {
                            selectedIndex = 1
                        }, label: {
                            if(selectedIndex == 1) {
                                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                                .frame(width: 50, height: 50, alignment: .center)
                                .mask(
                                    Image(systemName: "doc.text.magnifyingglass")
                                        .font(.title)
                                )
                                .frame(width: 50, height: 50, alignment: .leading)
                            }
                            else if(selectedIndex != 1) {
                                LinearGradient(gradient: Gradient(colors: [.red, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                                .frame(width: 50, height: 50, alignment: .center)
                                .mask(
                                    Image(systemName: "doc.text.magnifyingglass")
                                        .font(.title)
                                )
                                .frame(width: 50, height: 50, alignment: .leading)
                            }
                        })
                        Button(action: {
                            selectedIndex = 2
                        }, label: {
                            if(selectedIndex == 2) {
                                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                                .frame(width: 50, height: 50, alignment: .center)
                                .mask(
                                    Image(systemName: "house.fill")
                                        .font(.title)
                                )
                                .frame(width: 50, height: 50, alignment: .leading)
                            }
                            else if(selectedIndex != 2) {
                                LinearGradient(gradient: Gradient(colors: [.red, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                                .frame(width: 50, height: 50, alignment: .center)
                                .mask(
                                    Image(systemName: "house.fill")
                                        .font(.title)
                                )
                                .frame(width: 50, height: 50, alignment: .leading)
                            }
                        })
                        Button(action: {
                            selectedIndex = 3
                        }, label: {
                            if(selectedIndex == 3) {
                                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                                .frame(width: 50, height: 50, alignment: .center)
                                .mask(
                                    Image(systemName: "text.bubble.fill")
                                        .font(.title)
                                )
                                .frame(width: 50, height: 50, alignment: .leading)
                            }
                            else if(selectedIndex != 3) {
                                LinearGradient(gradient: Gradient(colors: [.red, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                                .frame(width: 50, height: 50, alignment: .center)
                                .mask(
                                    Image(systemName: "text.bubble.fill")
                                        .font(.title)
                                )
                                .frame(width: 50, height: 50, alignment: .leading)
                            }
                        })
                        Button(action: {
                            selectedIndex = 4
                        }, label: {
                            if(selectedIndex == 4) {
                                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                                .frame(width: 50, height: 50, alignment: .center)
                                .mask(
                                    Image(systemName: "gearshape.fill")
                                        .font(.title)
                                )
                                .frame(width: 50, height: 50, alignment: .leading)
                            }
                            else if(selectedIndex != 4) {
                                LinearGradient(gradient: Gradient(colors: [.red, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                                .frame(width: 50, height: 50, alignment: .center)
                                .mask(
                                    Image(systemName: "gearshape.fill")
                                        .font(.title)
                                )
                                .frame(width: 50, height: 50, alignment: .leading)
                            }
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
