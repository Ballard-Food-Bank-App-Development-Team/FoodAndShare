//
//  Question.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/14/21.
//

import Foundation

struct Question: Hashable {
    var ask: String
    var responses: [Answer]

    init(ask: String, responses: [String]) {
        self.ask = ask
        self.responses = [Answer]()
        for response in responses {
            self.responses.append(Answer(text: response))
        }
    }
}
