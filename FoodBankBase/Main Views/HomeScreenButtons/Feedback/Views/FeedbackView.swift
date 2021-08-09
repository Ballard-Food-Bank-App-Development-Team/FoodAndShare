//
//  FeedbackView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/8/21.
//

import SwiftUI

struct FeedbackView: View {
    
    @State private var subject: String = ""
    @State private var bodyText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                TextField("Subject", text: $subject)
                    .padding(.all)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 2)
                            .foregroundColor(Color("textFieldBackground"))
                    )
                    .padding()
                
                TextEditor(text: $bodyText)
                    .padding(.all)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 2)
                            .foregroundColor(Color("textFieldBackground"))
                    )
                    .padding()
                
                Button(action: {
                    EmailHelper.shared.sendEmail(subject: subject, body: bodyText, sendTo: "ian.m.holloway@gmail.com")
                }, label: {
                    Text("Send Email")
                        .padding()
                })
                .padding()
                
                Spacer()
                Spacer()
            }
            .padding()
            .navigationTitle("Feedback")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
