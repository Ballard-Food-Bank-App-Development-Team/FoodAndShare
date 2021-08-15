//
//  Survey.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/14/21.
//

import Foundation

struct Survey {
    var questions: [Question]

    init(questions: [Question]) {
        self.questions = questions
    }
}
