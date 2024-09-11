//
//  SwiftUIView.swift
//  
//
//  Created by Pavel Vaitsikhouski on 05.09.24.
//

import SwiftUI

public struct CheckBox: View {
    @Environment(\.checkBoxColorPalette) private var colorPalette
    @Binding var isChose: Bool

    public init(isChose: Binding<Bool>) {
        self._isChose = isChose
    }

    public var body: some View {
        Button {
            isChose.toggle()
        } label: {
            ZStack {
                if isChose {
                    RoundedRectangle(cornerRadius: .cornerRadius)
                        .frame(width: .size, height: .size)
                        .foregroundStyle(colorPalette.background)
                    Image(systemName: "checkmark")
                        .resizable()
                        .font(.system(size: .size / 2, weight: .semibold))
                        .frame(width: .size / 2, height: .size / 2)
                        .foregroundStyle(colorPalette.checkmark)
                } else {
                    RoundedRectangle(cornerRadius: .cornerRadius)
                        .stroke(lineWidth: .borderWidth)
                        .frame(width: .size, height: .size)
                        .foregroundStyle(colorPalette.background)
                }
            }
            .animation(.easeInOut, value: isChose)
        }
    }
}

// MARK: - EnvironmentKey

extension CheckBox {

    struct ColorPaletteKey: EnvironmentKey {
        static let defaultValue: ColorPalette = ColorPalette()
    }

    public struct ColorPalette: Sendable, Equatable, Hashable {
        var background: Color
        var checkmark: Color

        public init(
            background: Color = .black,
            checkmark: Color = .white
        ) {
            self.background = background
            self.checkmark = checkmark
        }
    }
}

public extension EnvironmentValues {

    var checkBoxColorPalette: CheckBox.ColorPalette {
        get { self[CheckBox.ColorPaletteKey.self] }
        set { self[CheckBox.ColorPaletteKey.self] = newValue }
    }
}

// MARK: - Constants

extension CGFloat {

    static let size: Self = 20
    static let cornerRadius: Self = 4
    static let borderWidth: Self = 1
}

#Preview {
    CheckBox(isChose: .constant(true))
}
