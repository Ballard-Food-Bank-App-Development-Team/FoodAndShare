//
//  Survey.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/20/21.
//

import Foundation

struct Survey: Hashable, Codable {
    enum CodingKeys: String, CodingKey {
        case questions
    }

    var questions: [Question]

    init(questions: [Question]) {
        self.questions = questions
    }
}
