//
//  HomeView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/17/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var user: FirebaseUserViewModel
    @State var selectedIndex = 1

    var body: some View {
        VStack {
            switch selectedIndex {
            case 0:
                DaySelectView()
            case 1:
                MainView()
            case 2:
                FeedbackView()
            case 3:
                AccountSettingsView()
            default:
                MainView()
            }

            Spacer()

            HStack {
                Spacer()
                Button(action: {
                    selectedIndex = 0
                }, label: {
                    LinearGradient(gradient: Gradient(colors: [.red, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                        .frame(width: 50, height: 50, alignment: .center)
                        .mask(
                            Image(systemName: "calendar.badge.clock")
                                .font(.title)
                        )
                        .background(
                            Circle()
                                .foregroundColor(selectedIndex == 0 ? Color.white : Color.black)
                                .frame(width: 50, height: 50)
                        )
                })
                Spacer()
                Button(action: {
                    selectedIndex = 1
                }, label: {
                    LinearGradient(gradient: Gradient(colors: [.red, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                        .frame(width: 50, height: 50, alignment: .center)
                        .mask(
                            Image(systemName: "house.fill")
                                .font(.title)
                        )
                })
                Spacer()
                Button(action: {
                    selectedIndex = 2
                }, label: {
                    LinearGradient(gradient: Gradient(colors: [.red, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                        .frame(width: 50, height: 50, alignment: .center)
                        .mask(
                            Image(systemName: "text.bubble.fill")
                                .font(.title)
                        )
                })
                Spacer()
                Button(action: {
                    selectedIndex = 3
                }, label: {
                    LinearGradient(gradient: Gradient(colors: [.red, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                        .frame(width: 50, height: 50, alignment: .center)
                        .mask(
                            Image(systemName: "gearshape.fill")
                                .font(.title)
                        )
                })
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width - UIScreen.main.bounds.width/16, height: 75, alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: 15)
            )
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
