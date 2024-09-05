//
//  File.swift
//  
//
//  Created by Pavel Vaitsikhouski on 05.09.24.
//

import Foundation

public struct OnboardingConfiguration {

    let fileName: String
    let colorPalette: ColorPalette

    public init(fileName: String, colorPalette: ColorPalette) {
        self.fileName = fileName
        self.colorPalette = colorPalette
    }
}
