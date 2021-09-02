//
//  SurveyListView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/28/21.
//

import SwiftUI

struct SurveyListView: View {
    @EnvironmentObject var user: FirebaseUserViewModel
    @StateObject var surveyList = SurveyListViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(self.surveyList.surveys, id: \.self) { survey in
                    NavigationLink(
                        destination: SurveyView(),
                        label: {
                            Text(survey.questions[0].ask)
                        })
                }
            }
        }
    }
}

struct SurveyListView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyListView()
            .environmentObject(FirebaseUserViewModel())
    }
}
