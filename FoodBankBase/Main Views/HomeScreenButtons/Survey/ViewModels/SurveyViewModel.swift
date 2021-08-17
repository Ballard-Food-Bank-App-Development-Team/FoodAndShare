//
//  SurveyViewModel.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/14/21.
//

import Foundation

class SurveyViewModel: ObservableObject {

    @Published var questions: [Question]

    func select(question: Int, answer: Int) {
        for answers in 0...(self.questions[question].responses.count - 1) {
            self.questions[question].responses[answers].chosen = false
        }
        self.questions[question].responses[answer].chosen = true
    }

    init(questions: [Question]) {
        self.questions = questions
        for question in 0...(questions.count - 1) {
            self.questions[question].index = question
        }
    }
}
