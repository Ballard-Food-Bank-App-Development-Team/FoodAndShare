//
//  SurveyCheckView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/25/21.
//

import SwiftUI

struct SurveyCheckView: View {
    @EnvironmentObject var surveyList: SurveyListViewModel

    var body: some View {
        Group {
            switch surveyList.isSurveyReady {
            case .loading:
                VStack {
                    Text("Loading...")
                }
            case .error:
                VStack {
                    Text("Error Loading Survey")
                }
            case .ready:
                SurveyListView()
            }
        }
    }
}

struct SurveyCheckView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyCheckView()
            .environmentObject(FirebaseUserViewModel())
    }
}
