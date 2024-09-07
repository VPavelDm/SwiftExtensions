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
            .progressView(isVisible: viewModel.passedSteps.last == nil) {
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
                navigationStackContentView(step: viewModel.passedSteps.last)
                    .navigationDestination(for: OnboardingStep.self, destination: navigationStackContentView(step:))
            }
            .environmentObject(viewModel)
        }
    }

    private var customToolbarView: some View {
        HStack {
            backButton
                .opacity(viewModel.passedSteps.count == 1 ? 0 : 1)
                .animation(.easeInOut, value: viewModel.passedSteps.count == 1)
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
            viewModel.passedSteps.removeLast()
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
    OnboardingView(configuration: .testData())
}
