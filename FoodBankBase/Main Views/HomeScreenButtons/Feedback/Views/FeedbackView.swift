//
//  FeedbackView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/8/21.
//

import SwiftUI

struct FeedbackView: View {
    var body: some View {
        Button(action: {
            EmailHelper.shared.sendEmail(subject: "Anything...", body: "", sendTo: "")
        }, label: {
            Text("Send Email")
        })
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
