//
//  SurveyListViewModel.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/28/21.
//

import Foundation
import FirebaseFirestore

class SurveyListViewModel: ObservableObject {
    enum SurveyState {
        case error, loading, ready
    }

    @Published var isSurveyReady: SurveyState

    @Published var surveys: [Survey]

    @Published var selectedSurvey: Survey = Survey(questions: [Question(ask: "", responses: [""])])

    private var database = Firestore.firestore()

    init() {
        self.isSurveyReady = .loading
        self.surveys = [Survey]()

        database.collection("surveyData").getDocuments { (querySnapshot, error) in
            if let error = error {
                self.isSurveyReady = .error
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    let result = Result {
                        try document.data(as: Survey.self)
                    }
                    switch result {
                    case .failure(let err):
                        self.isSurveyReady = .error
                        print("Error making object conform to Survey: \(err)")
                        return
                    case .success(let survey):
                        self.surveys.append(survey!)
                    }
                }
                self.isSurveyReady = .ready
            }
        }
    }
}
