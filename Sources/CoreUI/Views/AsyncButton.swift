//
//  File.swift
//  
//
//  Created by Pavel Vaitsikhouski on 08.09.24.
//

import SwiftUI

public struct AsyncButton<Label>: View where Label: View {
    var perform: () async -> Void
    var label: () -> Label

    public init(perform: @escaping () -> Void, label: @escaping () -> Label) {
        self.perform = perform
        self.label = label
    }

    public var body: some View {
        Button {
            Task { @MainActor in
                await perform()
            }
        } label: {
            label()
        }
    }
}
