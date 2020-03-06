//
//  Results.swift
//  QuizEngine
//
//  Created by Patrick Domingo on 3/6/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation

struct Results<Question: Hashable, Answer> {
    let answers: [Question: Answer]
    let score: Int
}
