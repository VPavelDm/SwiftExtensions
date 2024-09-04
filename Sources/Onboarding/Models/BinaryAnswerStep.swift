//
//  File.swift
//  
//
//  Created by Pavel Vaitsikhouski on 04.09.24.
//

import Foundation

struct BinaryAnswerStep: Sendable, Equatable, Hashable {
    let question: String
    let description: String?
    let firstAnswer: String
    let secondAnswer: String
}
