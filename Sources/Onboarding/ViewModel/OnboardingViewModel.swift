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

    // MARK: - Outputs

    @Published var steps: [OnboardingStep] = []

    // MARK: - Inits

    init(configuration: OnboardingConfiguration) {
        self.configuration = configuration
    }

    // MARK: - Intents

    func fetchSteps() async throws {        
    }
}
