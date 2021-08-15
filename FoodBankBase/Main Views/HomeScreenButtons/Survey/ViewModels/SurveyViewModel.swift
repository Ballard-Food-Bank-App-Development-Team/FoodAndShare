//
//  SurveyViewModel.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/14/21.
//

import Foundation

class SurveyViewModel: ObservableObject {

    @Published var surveyInfo: Survey

    func select(question: Int, answer: Int) {
        for answers in 0...(self.surveyInfo.questions[question].responses.count - 1) {
            self.surveyInfo.questions[question].responses[answers].chosen = false
        }
        self.surveyInfo.questions[question].responses[answer].chosen = true
    }

    init(questions: [Question]) {
        self.surveyInfo = Survey(questions: questions)
    }
}
