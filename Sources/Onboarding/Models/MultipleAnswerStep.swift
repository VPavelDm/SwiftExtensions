//
//  File.swift
//  
//
//  Created by Pavel Vaitsikhouski on 04.09.24.
//

import Foundation

struct MultipleAnswerStep: Sendable, Equatable, Hashable {
    let question: String
    let description: String?
    let answers: [String]
}
