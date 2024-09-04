//
//  SwiftUIView.swift
//  
//
//  Created by Pavel Vaitsikhouski on 04.09.24.
//

import SwiftUI

public struct OnboardingView: View {
    let colorPalette: ColorPalette

    public init(colorPalette: ColorPalette) {
        self.colorPalette = colorPalette
    }

    public var body: some View {
        Text("Hello, World!")
            .environment(\.colorPalette, colorPalette)
    }
}

#Preview {
    OnboardingView(colorPalette: .testData)
}
