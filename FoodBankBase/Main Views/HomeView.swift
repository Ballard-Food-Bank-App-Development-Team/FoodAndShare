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
        ZStack {
            switch selectedIndex {
            case 0:
                DaySelectView()
            case 1:
                MainView()
            case 2:
                FeedbackView()
            default:
                MainView()
            }
            VStack {
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
                    })
                    Spacer()
                    Button(action: {
                        selectedIndex = 1
                    }, label: {
                        LinearGradient(gradient: Gradient(colors: [.red, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                            .frame(width: 50, height: 50, alignment: .center)
                            .mask(
                                Image(systemName: "house.fill")
                                    .font(.largeTitle)
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
