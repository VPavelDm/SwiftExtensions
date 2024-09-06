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
    @Published var passedStepsAmount: Int = 0

    var passedStepsProcent: CGFloat {
        max(CGFloat(passedStepsAmount) / CGFloat(steps.count), 0.05)
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
        guard let nextStepIndex = steps.firstIndex(where: { $0.id == currentStep?.nextStepID }) else { return }
        currentStep = steps[nextStepIndex]
        passedStepsAmount += 1
    }
}
