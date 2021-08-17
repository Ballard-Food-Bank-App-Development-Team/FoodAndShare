//
//  Answer.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/14/21.
//

import Foundation

struct Answer: Hashable {
    var text: String
    var chosen: Bool = false
    var index: Int = 0

    init(text: String) {
        self.text = text
    }
}
