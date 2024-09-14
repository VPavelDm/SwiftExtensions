//
//  File.swift
//  
//
//  Created by Pavel Vaitsikhouski on 08.09.24.
//

import SwiftUI

public struct AsyncButton<Label>: View where Label: View {
    @Environment(\.asyncButtonColorPalette) private var colorPalette

    @State private var isLoading: Bool = false

    var perform: () async -> Void
    var label: () -> Label

    public init(perform: @escaping () async -> Void, label: @escaping () -> Label) {
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
                    .tint(colorPalette.progressView)
                    .opacity(isLoading ? 1 : 0)
            }
        }
    }
}

// MARK: - EnvironmentKey

private struct AsyncButtonColorPaletteKey: EnvironmentKey {
    static let defaultValue: AsyncButtonColorPalette = AsyncButtonColorPalette()
}

public struct AsyncButtonColorPalette: Sendable, Equatable, Hashable {
    var progressView: Color

    public init(progressView: Color = .black) {
        self.progressView = progressView
    }
}

public extension EnvironmentValues {

    var asyncButtonColorPalette: AsyncButtonColorPalette {
        get { self[AsyncButtonColorPaletteKey.self] }
        set { self[AsyncButtonColorPaletteKey.self] = newValue }
    }
}
