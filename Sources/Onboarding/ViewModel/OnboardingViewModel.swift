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
    let completion: () -> Void

    // MARK: - Inits

    init(configuration: OnboardingConfiguration, completion: @escaping () -> Void) {
        self.configuration = configuration
        self.service = OnboardingService(configuration: configuration)
        self.completion = completion
    }

    // MARK: - Intents

    func loadSteps() async throws {
        steps = try await service.fetchSteps()
            .filter(\.isNotUnknown)
        guard let firstStep = steps.first else { throw OnboardingError.noSteps }
        passedSteps.append(firstStep)
    }

    func onAnswer() {
        if let nextStepIndex = steps.firstIndex(where: { $0.id == passedSteps.last?.nextStepID }) {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            passedSteps.append(steps[nextStepIndex])
        } else {
            completion()
        }
    }

    func onBack() {
        guard passedSteps.count > 1 else { return }
        passedSteps.removeLast()
    }
}
