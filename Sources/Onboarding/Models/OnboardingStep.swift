//
//  File.swift
//  
//
//  Created by Pavel Vaitsikhouski on 04.09.24.
//

import Foundation

enum OnboardingStep: Sendable, Equatable, Hashable {
    case oneAnswer(OneAnswerStep)
    case binaryAnswer(BinaryAnswerStep)
    case multipleAnswer(MultipleAnswerStep)
    case description(DescriptionStep)
}
