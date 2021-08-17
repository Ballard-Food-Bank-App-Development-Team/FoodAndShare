//
//  SurveyView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/14/21.
//

import SwiftUI

struct SurveyView: View {
    @Environment(\.presentationMode) var presentation
    @StateObject var survey = SurveyViewModel(questions: [Question(ask: "Do you Like Ballard Food Bank?", responses: ["Yes", "No"])])

    var body: some View {
        VStack {
            ForEach(self.survey.questions, id: \.self) { question in
                VStack {
                    Group {
                        Text(question.ask)
                        VStack {
                            ForEach(question.responses, id: \.self) { response in
                                Button(action: {
                                    self.survey.select(question: question.index, answer: response.index)
                                }, label: {
                                    HStack {
                                        Circle()
                                            .foregroundColor(response.chosen ? Color.orange : Color.gray)
                                            .frame(width: 10, height: 10, alignment: .center)
                                            .padding()
                                        Text(response.text)
                                            .padding()
                                    }
                                })
                            }
                        }
                        .padding()
                    }
                    .padding()
                }
            }
            Button(action: {
                presentation.wrappedValue.dismiss()
            }, label: {
                Text("Submit")
            })
        }
        .padding(.all)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Survey")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(
                action: { presentation.wrappedValue.dismiss()
                }
                , label: {
                    Image(systemName: "arrow.backward")
                        .imageScale(.large)
                })
        )
    }
}

struct SurveyView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyView()
    }
}
