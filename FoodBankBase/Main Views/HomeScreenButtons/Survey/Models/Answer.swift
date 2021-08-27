//
//  Answer.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/14/21.
//

import Foundation

struct Answer: Hashable, Codable {
    enum CodingKeys: String, CodingKey {
        case text = "response"
        case amount
        case index
    }

    var text: String
    var chosen: Bool = false
    var index: Int = 0
    var amount: Int = 0

    init(text: String) {
        self.text = text
    }
}
