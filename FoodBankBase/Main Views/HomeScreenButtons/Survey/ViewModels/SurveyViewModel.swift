//
//  SurveyViewModel.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/14/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class SurveyViewModel: ObservableObject {

    @Published var questions: [Question]

    @Published var bit: Int = 0

    private var database = Firestore.firestore()

    func select(question: Int, answer: Int) {
        for answer in 0...(self.questions[question].responses.count - 1) {
            self.questions[question].responses[answer].chosen = false
        }
        self.questions[question].responses[answer].chosen = true
    }

    func surveyBitSend() {
        var index: Int = 1

        for question in self.questions {
            for response in question.responses {
                if response.chosen {
                    bit += (response.index + 1) * index
                    index *= 10
                    break
                }
                if response.index == question.responses.count - 1 {
                    index *= 10
                }
            }
        }

        let uid: String = Auth.auth().currentUser!.uid

        database.collection("surveyData").document("survey1Answers").setData(["\(uid)": self.bit], merge: true)
    }

    func surveyBitRecieve() {
    }

    func uploadSurvey(completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        let surveyQuestions = Survey(questions: questions)

        do {
            try database.collection("surveyData").document("survey1Answers").setData(from: surveyQuestions)
        } catch let error {
            let theError = error
            completionHandler(.failure(error))
            return
        }

        completionHandler(.success(true))
    }

    init(questions: [Question]) {
        self.questions = questions
        for question in 0...(questions.count - 1) {
            self.questions[question].index = question
        }
    }
}
