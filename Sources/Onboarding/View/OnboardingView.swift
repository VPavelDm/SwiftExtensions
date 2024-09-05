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
            .progressView(isVisible: viewModel.currentStep == nil) {
                contentLoadingView
            }
            .environment(\.colorPalette, colorPalette)
            .environmentObject(viewModel)
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
            if let currentStep = viewModel.currentStep {
                switch currentStep.type {
                case .oneAnswer(let oneAnswerStep):
                    OneAnswerView(step: oneAnswerStep)
                        .transition(transitionAnimation)
                case .binaryAnswer(let binaryAnswerStep):
                    Text("Binary")
                case .multipleAnswer(let multipleAnswerStep):
                    MultipleAnswerView(step: multipleAnswerStep)
                        .transition(transitionAnimation)
                case .description(let descriptionStep):
                    DescriptionStepView(step: descriptionStep)
                        .transition(transitionAnimation)
                case .unknown:
                    EmptyView()
                }
            }
        }
        .animation(.easeInOut, value: viewModel.currentStep)
    }

    private var contentLoadingView: some View {
        ProgressView()
            .tint(colorPalette.primaryButtonBackgroundColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(colorPalette.backgroundColor)
    }

    private var transitionAnimation: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading)
        )
    }
}

#Preview {
    OnboardingView(configuration: .testData())
}
