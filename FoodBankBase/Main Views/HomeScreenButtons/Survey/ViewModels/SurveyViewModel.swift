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

    private var database = Firestore.firestore()

    func select(question: Int, answer: Int) {
        for answer in 0...(self.questions[question].responses.count - 1) {
            self.questions[question].responses[answer].chosen = false
        }
        self.questions[question].responses[answer].chosen = true
    }

    func uploadSurvey(completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        let surveyQuestions = Survey(questions: self.questions)

        do {
            try database.collection("surveyData").document("survey1Answers").setData(from: surveyQuestions)
        } catch let error {
            completionHandler(.failure(error))
            return
        }

        completionHandler(.success(true))
    }

    func updateSurveyData(completionHandler: @escaping (Result<Bool, Error>) -> Void) {

        self.retriveSurveyData { (result) in
            switch result {
            case .failure(let err):
                completionHandler(.failure(err))
            case .success(var surveyRetrived):
                for question in self.questions {
                    for response in question.responses where response.chosen {
                        surveyRetrived.questions[question.index].responses[response.index].amount += 1
                    }
                }

                do {
                    try self.database.collection("surveyData").document("survey1Answers").setData(from: surveyRetrived)
                } catch let error {
                    completionHandler(.failure(error))
                    return
                }

                completionHandler(.success(true))
            }
        }
    }

    func retriveSurveyData(completionHandler: @escaping (Result<Survey, Error>) -> Void) {
        let docRef = database.collection("surveyData").document("survey1Answers")

        docRef.getDocument { (document, error) in
            // Check For errors
            if error != nil {
                completionHandler(.failure(error!))
                return
            }

            let result = Result {
                try document?.data(as: Survey.self)
            }

            switch result {
            case .failure(let err):
                completionHandler(.failure(err))
            case .success(let survey):
                if survey != nil {
                    completionHandler(.success(survey!))
                } else {
                    completionHandler(.failure(FirebaseErrors.documentDoesNotExist))
                }
            }
        }
    }

    init() {
        var surveyRetrived = Survey(questions: [Question(ask: "Error Displaying Survey Questions", responses: ["Error Displaying Survey Answers"])])
        self.questions = surveyRetrived.questions

        let docRef = database.collection("surveyData").document("survey1Answers")

        docRef.getDocument { (document, error) in
            // Check For errors
            if error != nil {
                print(error!)
                return
            }

            let result = Result {
                try document?.data(as: Survey.self)
            }

            switch result {
            case .failure(let err):
                print(err)
            case .success(var survey):
                if survey != nil {
                    for question in 0...(survey!.questions.count - 1) {
                        survey!.questions[question].index = question
                    }
                    surveyRetrived = survey!
                    self.questions = surveyRetrived.questions
                } else {
                    print(FirebaseErrors.documentDoesNotExist)
                }
            }
        }
    }
}
