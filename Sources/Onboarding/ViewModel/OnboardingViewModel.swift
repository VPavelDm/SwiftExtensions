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

    private let configuration: OnboardingConfiguration
    private let service: OnboardingService

    // MARK: - Outputs

    @Published var steps: [OnboardingStep] = []
    @Published var currentStep: OnboardingStep?

    // MARK: - Inits

    init(configuration: OnboardingConfiguration) {
        self.configuration = configuration
        self.service = OnboardingService(configuration: configuration)
    }

    // MARK: - Intents

    func loadSteps() async throws {
        steps = try await service.fetchSteps()
        currentStep = steps.first
    }

    func onAnswer() {
        guard let currentStep else { return }
        guard let currentStepIndex = steps.firstIndex(of: currentStep) else { return }
        if currentStepIndex != steps.count - 1 {
            self.currentStep = steps[currentStepIndex + 1]
        }
    }
}
