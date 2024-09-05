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

// MARK: - Convert

extension OnboardingStep {

    init?(response: OnboardingStepResponse) {
        switch response.type {
        case .oneAnswer(let payload):
            self = .oneAnswer(OneAnswerStep(response: payload))
        case .multipleAnswer(let payload):
            self = .multipleAnswer(MultipleAnswerStep(response: payload))
        default:
            return nil
        }
    }
}
