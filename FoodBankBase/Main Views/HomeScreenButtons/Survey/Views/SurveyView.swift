//
//  SurveyView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/14/21.
//

import SwiftUI

struct SurveyView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var user: FirebaseUserViewModel

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
                                    .foregroundColor(Color("textGrey"))
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
                                                .foregroundColor(Color("darkInvert"))
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
                
                Button(action: {
                    self.survey.updateSurveyData { (result) in
                        switch result {
                        case .failure(let err):
                            print(err)
                        case .success(_):
                            print("Succesfully Updated Survey Value")
                        }
                    }
                    self.user.updateSurveyStatus { (result) in
                        switch result {
                        case .failure(let err):
                            print(err)
                        case .success(_):
                            print("Succesfully Updated Survey State")
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
                        .accentColor(Color("darkInvert"))
                })
        )
    }
}

struct SurveyView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyView()
            .environmentObject(FirebaseUserViewModel())
    }
}
