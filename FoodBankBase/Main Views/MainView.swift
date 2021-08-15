//
//  MainView.swift
//  FoodBankBase
//
//  Created by Benjamin Roberts on 8/8/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        // TODO: Create a seprate view for the big buttons as they are very simular
        NavigationView {
            VStack {
                // MARK: - Account Settings
                HStack {
                    NavigationLink(
                        destination: AccountSettingsView(),
                        label: {
                            LinearGradient(gradient: Gradient(colors: [.red, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing)
                                .frame(width: 29, height: 29,   alignment: .center)
                                .mask(
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                )
                                .background(
                                    Circle()
                                        .foregroundColor(Color("spaceGrey"))
                                        .shadow(color: Color("customOrange"), radius: 5, y: 1)
                                )
                                .padding(.trailing)
                                .padding(.trailing)
                        }
                    )
                }

                // MARK: - Logo
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
                            Image("infoIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70,   alignment: .topLeading)
                                .frame(width: 50, height: 50)
                                .background(Color.white)
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text("Info")
                                    .foregroundColor(Color("navyBlue"))
                                    .font(.custom("HelveticaNeue-Medium", size: 24))
                                Text("Click to learn more")// 19
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
                // MARK: - Survey Button
                NavigationLink(
                    destination: SurveyView(),
                    label: {
                        Text("Go to Survey View")
                    })
            }
            .navigationBarHidden(true)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
