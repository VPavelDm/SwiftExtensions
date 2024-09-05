//
//  File.swift
//  
//
//  Created by Pavel Vaitsikhouski on 05.09.24.
//

import Foundation

final class OnboardingService {

    // MARK: - Properties

    let configuration: OnboardingConfiguration

    // MARK: - Inits

    init(configuration: OnboardingConfiguration) {
        self.configuration = configuration
    }

    // MARK: - Intents

    func fetchSteps() async throws {
        guard let fileURL = Bundle.main.url(forResource: configuration.fileName, withExtension: "json") else {
            throw OnboardingError.fileDoesNotExist
        }
        let data = try Data(contentsOf: fileURL)
        let steps = try JSONDecoder().decode([OnboardingStepResponse].self, from: data)
        print(steps)
    }
}
