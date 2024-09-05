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
            .environment(\.colorPalette, colorPalette)
            .onFirstAppear {
                do {
                    try await viewModel.fetchSteps()
                } catch {
                    showError = true
                }
            }
    }

    private var contentView: some View {
        Text("Hello, World!")
    }
}

#Preview {
    OnboardingView(configuration: .testData())
}
