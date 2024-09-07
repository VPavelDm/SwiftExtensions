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

    public init(configuration: OnboardingConfiguration, completion: @escaping ([UserAnswer]) -> Void) {
        self._viewModel = StateObject(wrappedValue: OnboardingViewModel(
            configuration: configuration,
            completion: completion
        ))
        self.colorPalette = configuration.colorPalette
    }

    public var body: some View {
        contentView
            .progressView(isVisible: viewModel.currentStep == nil) {
                contentLoadingView
            }
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
        VStack {
            customToolbarView
            NavigationStack(path: $viewModel.passedSteps) {
                navigationStackContentView(step: viewModel.steps.first)
                    .navigationDestination(for: OnboardingStep.self, destination: navigationStackContentView(step:))
            }
            .environmentObject(viewModel)
        }
    }

    private var customToolbarView: some View {
        HStack {
            backButton
                .opacity(viewModel.userAnswers.isEmpty ? 0 : 1)
                .animation(.easeInOut, value: viewModel.userAnswers.isEmpty)
            ProgressBarView(completed: viewModel.passedStepsProcent)
            backButton.opacity(0)
        }
        .padding([.horizontal, .top])
    }

    private func navigationStackContentView(step: OnboardingStep?) -> some View {
        VStack {
            switch step?.type {
            case .oneAnswer(let oneAnswerStep):
                OneAnswerView(step: oneAnswerStep)
            case .binaryAnswer(let binaryAnswerStep):
                BinaryAnswerView(step: binaryAnswerStep)
            case .multipleAnswer(let multipleAnswerStep):
                MultipleAnswerView(step: multipleAnswerStep)
            case .description(let descriptionStep):
                DescriptionStepView(step: descriptionStep)
            case .unknown, .none:
                EmptyView()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    var backButton: some View {
        BackButton {
            viewModel.onBack()
        }
    }

    private var contentLoadingView: some View {
        ProgressView()
            .tint(colorPalette.primaryButtonBackgroundColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(colorPalette.backgroundColor)
    }
}

#Preview {
    OnboardingView(configuration: .testData(), completion: { _ in})
}
