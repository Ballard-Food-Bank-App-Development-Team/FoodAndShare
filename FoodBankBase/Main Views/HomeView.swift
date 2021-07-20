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
            ZStack {
                Color("greyBackground")
                    .ignoresSafeArea()
                
                VStack {
                    // MARK: - Logo
                    
                    VStack {
                        Image("foodbankMain")
                            .resizable()
                            .frame(width: 350, height: 350, alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        HStack {
                            Spacer()
                            Text("Created by Ian and Ben")
                                .font(.caption)
                                .padding(.trailing)
                        }
                    }
                    // MARK: - Calendar Button
                    NavigationLink(
                        destination: DaySelectView(),
                        label: {
                            HStack {
                                Image("calendarIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50,   alignment: .topLeading)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color("customOrange"), lineWidth: 3))
                                VStack(alignment: .leading) {
                                    Text("Calendar")
                                        .font(.custom("Headine", size: 24))
                                    
                                    Text("Volunteer Times ")
                                        .font(.custom("Headine", size: 14))
                                }
                                    
                                }
                                .frame(width: UIScreen.main.bounds.width - UIScreen.main.bounds.width/5, height: 80, alignment: .center)
                                .accentColor(.black)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.white)
                                )
                            })
                        
                    // MARK: - Map Button
                    NavigationLink(
                        destination: FoodBankMapView(),
                        label: {
                            HStack {
                                Image("mapIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 22,   alignment: .topLeading)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color("customOrange"), lineWidth: 3))
                                VStack(alignment: .leading) {
                                    Text("Map")
                                        .font(.custom("Headine", size: 24))
                                    
                                    Text("Locate resources")
                                        .font(.custom("Headine", size: 14))
                                }
                                
                            }
                            .frame(width: UIScreen.main.bounds.width - UIScreen.main.bounds.width/5, height: 80, alignment: .center)
                            .accentColor(.black)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.white)
                            )
                        })
                    // MARK: - Info Button
                    NavigationLink(
                        destination: Text("Information Page"),
                        label: {
                            HStack {
                                Image("informationIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25,   alignment: .topLeading)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color("customOrange"), lineWidth: 3))
                                VStack(alignment: .leading) {
                                    Text("Info")
                                        .font(.custom("Headine", size: 24))
                                    
                                    Text("Learn more info ")
                                        .font(.custom("Headine", size: 14))
                                }
                                
                            }
                            .frame(width: UIScreen.main.bounds.width - UIScreen.main.bounds.width/5, height: 80, alignment: .center)
                            .accentColor(.black)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.white)
                            )
                        })
                    // MARK: - News Button
                    NavigationLink(
                        destination: Text("News"),
                        label: {
                            HStack {
                                Image("newsIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22, height: 22,   alignment: .topLeading)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color("customOrange"), lineWidth: 3))
                                VStack(alignment: .leading) {
                                    Text("News")
                                        .font(.custom("Headine", size: 24))
                                    
                                    Text("Foodbank news ")
                                        .font(.custom("Headine", size: 14))
                                }
                                
                            }
                            .frame(width: UIScreen.main.bounds.width - UIScreen.main.bounds.width/5, height: 80, alignment: .center)
                            .accentColor(.black)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.white)
                            )
                        })
                    
                    // MARK: - Account
                    NavigationLink(
                        destination: AccountSettingsView(),
                        label: {
                            HStack {
                                Image(systemName: "person")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color("customOrange"), lineWidth: 3))
                                VStack(alignment: .leading) {
                                    Text("Account")
                                        .font(.custom("Headine", size: 24))
                                    
                                    Text("Account settings")
                                        .font(.custom("Headine", size: 14))
                                }
                                
                            }
                            .frame(width: UIScreen.main.bounds.width - UIScreen.main.bounds.width/5, height: 80, alignment: .center)
                            .accentColor(.black)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.white)
                            )
                        })
                    Spacer()
                }
            }
            .onAppear {
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
