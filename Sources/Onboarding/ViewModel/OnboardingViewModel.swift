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
    @Published var currentStep: OnboardingStep?
    @Published var passedSteps: [OnboardingStep] = []

    var passedStepsProcent: CGFloat {
        guard let maxStepsInChain = currentStep?.maxStepsInChain else { return 1 }
        return min(CGFloat(passedSteps.count + 1) / CGFloat(maxStepsInChain), 1)
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
        currentStep = steps.first
    }

    func onAnswer() {
        guard let currentStep else { return }
        guard let nextStepIndex = steps.firstIndex(where: { $0.id == currentStep.nextStepID }) else { return }
        passedSteps.append(currentStep)
        self.currentStep = steps[nextStepIndex]
    }

    func onBack() {
        currentStep = passedSteps.removeLast()
    }
}
