//
//  SurveyView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/14/21.
//

import SwiftUI

struct SurveyView: View {
    @Environment(\.presentationMode) var presentation

    @StateObject var survey = SurveyViewModel(
        questions: [
            // Question #1
            Question(
                ask: "Would you recommend the Ballard Foodbank?",
                responses: [
                    "Yes",
                    "No"
                ]),
            // Question #2
            Question(
                ask: "What types of foods do you want more of?",
                responses: [
                    "Dry foods",
                    "Produce",
                    "Frozen Food",
                    "Dairy"
                ]),
            // Question #3
            Question(
                ask: "Do you get enough food?",
                responses: [
                    "I barely have enough",
                    "Sometimes I get enough",
                    "I get plenty of food"
                ]),
            // Question #4
            Question(
                ask: "What times do you want the foodbank open?",
                responses: [
                    "Earlier",
                    "Later",
                    "Earlier & Later",
                    "It's Good"
                ])
        ])
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    ForEach(self.survey.questions, id: \.self) { question in
                        Group {
                            HStack {
                                Text(question.ask)
                                    .bold()
                                    .font(.title3)
                                Spacer()
                            }
                            VStack {
                                ForEach(question.responses, id: \.self) { response in
                                    Button(action: {
                                        self.survey.select(question: question.index, answer: response.index)
                                    }, label: {
                                        HStack {
                                            Circle()
                                                .strokeBorder(Color(.black), lineWidth: 1)
                                                .background(Circle().foregroundColor(response.chosen ? .blue : .white))
                                                .frame(width: 20, height: 20, alignment: .center)
                                                .padding(.horizontal, 10)
                                            Text(response.text)
                                                .foregroundColor(.black)
                                                .font(.body)
                                            Spacer()
                                        }
                                        .padding(.all, 2)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(response.chosen ? Color.gray.opacity(0.2) : Color(.systemBackground))
                                        )
                                        .padding(.horizontal, 10)
                                        .padding(.all, 5)
                                    })
                                }
                            }
                        }
                    }
                }
                .padding(.all, 20)

                /*Button(action: {
                    self.survey.uploadSurvey { (result) in
                        switch result {
                        case .failure(let err):
                            print(err)
                        case .success(_):
                            print("Succesfully Updated Value")
                        }
                    }
                }, label: {
                    Text("Upload")
                })
                .padding()
                .foregroundColor(Color(.systemBackground))
                .frame(width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 2))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.blue)
                )
                .padding()*/

                Button(action: {
                    self.survey.updateSurveyData { (result) in
                        switch result {
                        case .failure(let err):
                            print(err)
                        case .success(_):
                            print("Succesfully Updated Value")
                        }
                    }
                }, label: {
                    Text("Submit")
                })
                .padding()
                .foregroundColor(Color(.systemBackground))
                .frame(width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 2))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.blue)
                )
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Survey")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(
                action: { presentation.wrappedValue.dismiss()
                }, label: {
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
