//
//  Question.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/14/21.
//

import Foundation

struct Question: Hashable, Codable {
    enum CodingKeys: String, CodingKey {
        case ask = "question"
        case responses
    }

    var ask: String
    var responses: [Answer]
    var index: Int = 0

    init(ask: String, responses: [String]) {
        self.ask = ask
        self.responses = [Answer]()
        for response in 0...(responses.count - 1) {
            self.responses.append(Answer(text: responses[response]))
            self.responses[response].index = response
        }
    }
}
