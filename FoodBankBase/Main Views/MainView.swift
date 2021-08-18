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
                Spacer()
                // MARK: - Logo
                Image("foodbankMain")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 160,   alignment: .center)
                Spacer()
                // MARK: - Info Button
                NavigationLink(
                    destination: InfoView(),
                    label: {
                        BigButtonHomeScreenView(
                            name: "Info",
                            description: "Click to learn more",
                            imageName: "infoIcon",
                            frame: 70
                        )
                    })

                // MARK: - Map Button
                NavigationLink(
                    destination: FoodBankMapView(),
                    label: {
                        BigButtonHomeScreenView(
                            name: "Map",
                            description: "Find help near you ",
                            imageName: "mapIcon",
                            frame: 100
                        )
                    })

                // MARK: - News Button
                NavigationLink(
                    destination: NewsUIView(),
                    label: {
                        BigButtonHomeScreenView(
                            name: "News",
                            description: "Our latest updates ",
                            imageName: "newsIcon",
                            frame: 100
                        )
                    })
                /*
                // MARK: - Survey Button
                NavigationLink(
                    destination: SurveyView(),
                    label: {
                        BigButtonHomeScreenView(
                            name: "Surveys",
                            description: "Help give feedback ",
                            imageName: "surveyIcon",
                            frame: 50
                        )
                    })
                */
                Spacer()
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
