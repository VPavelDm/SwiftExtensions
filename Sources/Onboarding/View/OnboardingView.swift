//
//  SwiftUIView.swift
//  
//
//  Created by Pavel Vaitsikhouski on 04.09.24.
//

import SwiftUI
import CoreUI

public struct OnboardingView: View {
    @StateObject private var viewModel: OnboardingViewModel

    @State private var showError: Bool = false

    let colorPalette: ColorPalette

    public init(configuration: OnboardingConfiguration) {
        self._viewModel = StateObject(wrappedValue: OnboardingViewModel(configuration: configuration))
        self.colorPalette = configuration.colorPalette
    }

    public var body: some View {
        contentView
            .animation(.easeInOut, value: viewModel.steps.isEmpty)
            .environment(\.colorPalette, colorPalette)
            .background(colorPalette.backgroundColor)
            .onFirstAppear {
                do {
                    try await viewModel.loadSteps()
                } catch {
                    showError = true
                }
            }
    }

    @ViewBuilder
    private var contentView: some View {
        if let currentStep = viewModel.currentStep {
            switch currentStep {
            case .oneAnswer(let oneAnswerStep):
                OneAnswerView(step: oneAnswerStep)
            case .binaryAnswer(let binaryAnswerStep):
                Text("Binary")
            case .multipleAnswer(let multipleAnswerStep):
                MultipleAnswerView(step: multipleAnswerStep)
            case .description(let descriptionStep):
                Text("Description")
            }
        } else {
            ProgressView()
                .tint(colorPalette.primaryButtonBackgroundColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(colorPalette.backgroundColor)
        }
    }
}

#Preview {
    OnboardingView(configuration: .testData())
}
