//
//  SurveyCheckView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/25/21.
//

import SwiftUI

struct SurveyCheckView: View {
    @EnvironmentObject var user: FirebaseUserViewModel

    var body: some View {
        Group {
            if self.user.showSurveys == false {
                Spacer()
                Text("Survey Already Completed")
                Spacer()
            } else {
                SurveyView()
            }
        }
        .onAppear {
            self.user.checkSurveyStatus { (result) in
                switch result {
                case .failure(_):
                    self.user.showSurveys = false
                case .success(_): break
                }
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
