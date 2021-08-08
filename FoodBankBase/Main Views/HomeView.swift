//
//  HomeView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/17/21.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @EnvironmentObject var user: FirebaseUserViewModel

    var body: some View {
        NavigationView {
            VStack {
                // MARK: - Logo
                HStack {
                    Spacer()

                    NavigationLink(
                        destination: DaySelectView(),
                        label: {
                            HStack {
                                Image("calendarIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40,   alignment: .topLeading)
                                    .frame(width: 40, height: 40)
                                    .background(Color("spaceGrey"))
                                    .clipShape(Rectangle())
                                Text("Calendar")
                                    .foregroundColor(Color("navyBlue"))
                                    .font(.custom("HelveticaNeue-Medium", size: 20))
                            }
                            .frame(width: UIScreen.main.bounds.width - UIScreen.main.bounds.width/4, height: 50, alignment: .center)
                            .accentColor(.black)
                            .background(
                                Capsule()
                                    .foregroundColor(Color("spaceGrey"))
                                    .shadow(color: Color("customOrange"), radius: 5, y: 1)
                            )
                        })

                    Spacer()
                    Spacer()
                    Spacer()

                    NavigationLink(
                        destination: AccountSettingsView(),
                        label: {
                            ZStack {
                                Circle()
                                    .frame(width: 60, height: 60,   alignment: .center)
                                    .foregroundColor(Color("spaceGrey"))
                                    .shadow(color: Color("customOrange"), radius: 5, y: 1)

                                LinearGradient(gradient: Gradient(colors: [.red, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                                    .frame(width: 29, height: 29,   alignment: .center)
                                    .mask(
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                    )

                            }
                        }
                    )

                    Spacer()
                }

                /*
                Image("foodbankHome")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 180,   alignment: .center)
                    .frame(width: 360, height: 140)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                */

                Image("foodbankMain")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 160,   alignment: .center)

                // MARK: - Info Button
                NavigationLink(
                    destination: InfoView(),
                    label: {
                        HStack {
                            Spacer()
                            Spacer()
                            Image("infoIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70,   alignment: .topLeading)
                                .frame(width: 50, height: 50)
                                .background(Color.white)
                                .clipShape(Circle())
                                // .overlay(Circle().stroke(Color("customOrange"), lineWidth: 2))
                            VStack(alignment: .leading) {
                                Text("Info")
                                    .foregroundColor(Color("navyBlue"))
                                    .font(.custom("HelveticaNeue-Medium", size: 24))

                                Text("Click to learn more")// 19
                                    .foregroundColor(Color("textGrey"))
                                    .font(.custom("HelveticaNeue-Medium", size: 16))
                            }
                            Spacer()
                            Spacer()
                            Image("orangePlus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30,   alignment: .center)
                                .frame(width: 50, height: 50)
                                .background(Color("spaceGrey"))
                            Spacer()

                        }
                        .frame(width: UIScreen.main.bounds.width - UIScreen.main.bounds.width/4, height: 100, alignment: .center)
                        .accentColor(.black)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(Color("spaceGrey"))
                                .shadow(color: Color("customOrange"), radius: 5, y: 1)
                        )
                    })
                Spacer()
                // MARK: - Info Button
                NavigationLink(
                    destination: FoodBankMapView(),
                    label: {
                        HStack {
                            Spacer()
                            Image("mapIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100,   alignment: .center)
                                .frame(width: 50, height: 50)
                                .background(Color.white)
                                .clipShape(Circle())
                                // .overlay(Circle().stroke(Color("customOrange"), lineWidth: 2))
                            VStack(alignment: .leading) {
                                Text("Map")
                                    .foregroundColor(Color("navyBlue"))
                                    .font(.custom("HelveticaNeue-Medium", size: 24))

                        Text("Find help near you ")// 19
                                    .foregroundColor(Color("textGrey"))
                                    .font(.custom("HelveticaNeue-Medium", size: 16))
                            }
                            Spacer()
                            Image("orangePlus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30,   alignment: .center)
                                .frame(width: 50, height: 50)
                                .background(Color("spaceGrey"))
                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.width - UIScreen.main.bounds.width/4, height: 100, alignment: .center)
                        .accentColor(.black)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(Color("spaceGrey"))
                                .shadow(color: Color("customOrange"), radius: 5, y: 1)
                        )
                    })
                Spacer()
                // MARK: - News Button
                NavigationLink(
                    destination: NewsUIView(),
                    label: {
                        HStack {
                            Spacer()
                            Image("newsIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100,   alignment: .center)
                                .frame(width: 50, height: 50)
                                .background(Color.white)
                                .clipShape(Circle())
                                // .overlay(Circle().stroke(Color("navyBlue"), lineWidth: 2))
                            VStack(alignment: .leading) {
                                Text("News")
                                    .foregroundColor(Color("navyBlue"))
                                    .font(.custom("HelveticaNeue-Medium", size: 24))

                                Text("Our latest updates ") // 19
                                    .foregroundColor(Color("textGrey"))
                                    .font(.custom("HelveticaNeue-Medium", size: 16))
                            }
                            Spacer()
                            Image("orangePlus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30,   alignment: .center)
                                .frame(width: 50, height: 50)
                                .background(Color("spaceGrey"))
                            Spacer()

                        }
                        .frame(width: UIScreen.main.bounds.width - UIScreen.main.bounds.width/4, height: 100, alignment: .center)
                        .accentColor(.black)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(Color("spaceGrey"))
                                .shadow(color: Color("customOrange"), radius: 5, y: 1)
                        )
                    })
                Spacer()
                Spacer()
                Spacer()
        }            .onAppear {
                self.user.checkUserState()
            }
            .navigationBarHidden(true)
            /*.navigationTitle("Food Bank")
            .navigationBarItems(
                trailing:
                    NavigationLink(destination: AccountSettingsView()) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.title)
                            .padding(.all)
                    }
            )*/
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(FirebaseUserViewModel())
    }
}
