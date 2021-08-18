//
//  SurveyView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/14/21.
//

import SwiftUI

struct SurveyView: View {
    @Environment(\.presentationMode) var presentation

    @State private var showAlert: Bool = false

    @StateObject var survey = SurveyViewModel(
        questions: [
            // Question #1
            Question(
                ask: "Do you Like Ballard Food Bank?",
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
                    "Frozen meals",
                    "Same foods"
                ]),
            // Question #3
            Question(
                ask: "Do you need more food from Ballard Food Bank?",
                responses: [
                    "I barely have enough",
                    "Sometimes I get enough",
                    "I get plenty of food"
                ]),
            // Question #4
            Question(
                ask: "Is the Ballard Food Bank open at the right times?",
                responses: [
                    "It needs to open earlier",
                    "It needs to open later",
                    "It needs to open earlier & later",
                    "The current times are good"
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
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color(.systemBackground))
                                    .shadow(color: Color("customOrange"), radius: 3)
                            )
                            VStack {
                                ForEach(question.responses, id: \.self) { response in
                                    Button(action: {
                                        self.survey.select(question: question.index, answer: response.index)
                                    }, label: {
                                        HStack {
                                            Circle()
                                                .foregroundColor(response.chosen ? .orange : .gray)
                                                .frame(width: 10, height: 10, alignment: .center)
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
                                                .shadow(radius: 1)
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

                Button(action: {
                    showAlert = true
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Text("Submit")
                })
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Survey Sumbited Successfully"), message: Text("Your responses have been recorded"), dismissButton: .default(Text("OK")))
                }
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
