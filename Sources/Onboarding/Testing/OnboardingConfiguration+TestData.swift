//
//  File.swift
//  
//
//  Created by Pavel Vaitsikhouski on 05.09.24.
//

import Foundation

extension OnboardingConfiguration {

    static func testData() -> Self {
        Self(
            url: URL(string: "https://google.com")!,
            colorPalette: .testData
        )
    }
}
