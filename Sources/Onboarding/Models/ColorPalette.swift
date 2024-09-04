//
//  File.swift
//  
//
//  Created by Pavel Vaitsikhouski on 04.09.24.
//

import SwiftUI

public struct ColorPalette: Sendable {
    let backgroundColor: Color
    let primaryTextColor: Color
    let secondaryTextColor: Color
    let buttonTextColor: Color
    let buttonBackgroundColor: Color

    public init(
        backgroundColor: Color,
        primaryTextColor: Color,
        secondaryTextColor: Color,
        buttonTextColor: Color,
        buttonBackgroundColor: Color
    ) {
        self.backgroundColor = backgroundColor
        self.primaryTextColor = primaryTextColor
        self.secondaryTextColor = secondaryTextColor
        self.buttonTextColor = buttonTextColor
        self.buttonBackgroundColor = buttonBackgroundColor
    }
}

// MARK: - Environment

struct ColorPaletteKey: EnvironmentKey {
    static let defaultValue: ColorPalette = .testData
}

extension EnvironmentValues {
    var colorPalette: ColorPalette {
        get { self[ColorPaletteKey.self] }
        set { self[ColorPaletteKey.self] = newValue }
    }
}
