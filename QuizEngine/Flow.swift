//
//  Flow.swift
//  QuizEngine
//
//  Created by Patrick Domingo on 3/5/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
    func routeTo(result: [String: String])
}

class Flow {
    private let router: Router
    private let questions: [String]
    private var result: [String: String] = [:]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeNext(from: firstQuestion))
        } else {
            router.routeTo(result: [:])
        }
    }
    
    private func routeNext(from question: String) -> Router.AnswerCallback {
        return { [weak self] answer in
            guard let self = self else { return }
            if let currentQuestionIndex = self.questions.firstIndex(of: question) {
                self.result[question] = answer
                if currentQuestionIndex+1 < self.questions.count {
                    let nextQuestion = self.questions[currentQuestionIndex+1]
                    self.router.routeTo(question: nextQuestion, answerCallback: self.routeNext(from: nextQuestion))
                } else {
                    self.router.routeTo(result: self.result)
                }
            }
        }
    }
}
