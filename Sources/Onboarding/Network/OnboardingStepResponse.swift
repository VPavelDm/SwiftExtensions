//
//  File.swift
//  
//
//  Created by Pavel Vaitsikhouski on 05.09.24.
//

import Foundation

struct OnboardingStepResponse: Decodable {
    let id: UUID
    let type: OnboardingStepType

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case payload
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case "multipleAnswer":
            let payload = try container.decode(MultipleAnswerStep.self, forKey: .payload)
            self.type = .multipleAnswer(payload)
        case "oneAnswer":
            let payload = try container.decode(OneAnswerStep.self, forKey: .payload)
            self.type = .oneAnswer(payload)
        default:
            self.type = .unknown
        }
    }

    enum OnboardingStepType {
        case oneAnswer(OneAnswerStep)
        case multipleAnswer(MultipleAnswerStep)
        case unknown
    }

    struct OneAnswerStep: Decodable {
        let title: String
        let description: String?
        let answers: [String]
    }

    struct MultipleAnswerStep: Decodable {
        let title: String
        let description: String?
        let answers: [String]
    }
}
