//
//  File.swift
//  
//
//  Created by Pavel Vaitsikhouski on 05.09.24.
//

import Foundation

public struct OnboardingConfiguration {

    let url: URL
    let colorPalette: ColorPalette

    public init(url: URL, colorPalette: ColorPalette) {
        self.url = url
        self.colorPalette = colorPalette
    }
}
