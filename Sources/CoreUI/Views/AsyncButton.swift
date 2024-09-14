//
//  File.swift
//  
//
//  Created by Pavel Vaitsikhouski on 08.09.24.
//

import SwiftUI

public struct AsyncButton<Label>: View where Label: View {
    @State private var isLoading: Bool = false

    private var colorPalette: any AsyncButtonColorPalette
    var perform: () async -> Void
    var label: () -> Label

    public init(colorPalette: any AsyncButtonColorPalette, perform: @escaping () async -> Void, label: @escaping () -> Label) {
        self.colorPalette = colorPalette
        self.perform = perform
        self.label = label
    }

    public var body: some View {
        Button {
            Task { @MainActor in
                isLoading = true
                await perform()
                isLoading = false
            }
        } label: {
            ZStack {
                label().opacity(isLoading ? 0 : 1)
                ProgressView()
                    .tint(colorPalette.asyncButtonProgressView)
                    .opacity(isLoading ? 0 : 1)
            }
        }
    }
}

// MARK: -

public protocol AsyncButtonColorPalette {
    var asyncButtonProgressView: Color { get }
}
