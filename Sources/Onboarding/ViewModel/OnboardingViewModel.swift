//
//  File.swift
//  
//
//  Created by Pavel Vaitsikhouski on 05.09.24.
//

import SwiftUI

@MainActor
final class OnboardingViewModel: ObservableObject {

    // MARK: - Properties

    private let service: OnboardingService

    // MARK: - Outputs

    @Published var steps: [OnboardingStep] = []
    @Published var passedSteps: [OnboardingStep] = []

    var passedStepsProcent: CGFloat {
        guard let maxStepsInChain = passedSteps.last?.maxStepsInChain else { return 1 }
        return min(CGFloat(passedSteps.count) / CGFloat(maxStepsInChain), 1)
    }

    let configuration: OnboardingConfiguration

    // MARK: - Inits

    init(configuration: OnboardingConfiguration) {
        self.configuration = configuration
        self.service = OnboardingService(configuration: configuration)
    }

    // MARK: - Intents

    func loadSteps() async throws {
        steps = try await service.fetchSteps()
            .filter(\.isNotUnknown)
        guard let firstStep = steps.first else { throw OnboardingError.noSteps }
        passedSteps.append(firstStep)
    }

    func onAnswer() {
        guard let nextStepIndex = steps.firstIndex(where: { $0.id == passedSteps.last?.nextStepID }) else { return }
        passedSteps.append(steps[nextStepIndex])
    }

    func onBack() {
        guard passedSteps.count > 1 else { return }
        passedSteps.removeLast()
    }
}
