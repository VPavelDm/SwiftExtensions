//
//  SwiftUIView.swift
//  
//
//  Created by Pavel Vaitsikhouski on 05.09.24.
//

import SwiftUI

public struct CheckBox: View {
    var colorPalette: any CheckBoxColorPalette
    @Binding var isChose: Bool

    public init(colorPalette: any CheckBoxColorPalette, isChose: Binding<Bool>) {
        self.colorPalette = colorPalette
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
                        .foregroundStyle(colorPalette.checkboxBackground)
                    Image(systemName: "checkmark")
                        .resizable()
                        .font(.system(size: .size / 2, weight: .semibold))
                        .frame(width: .size / 2, height: .size / 2)
                        .foregroundStyle(colorPalette.checkboxCheckmark)
                } else {
                    RoundedRectangle(cornerRadius: .cornerRadius)
                        .stroke(lineWidth: .borderWidth)
                        .frame(width: .size, height: .size)
                        .foregroundStyle(colorPalette.checkboxBackground)
                }
            }
            .animation(.easeInOut, value: isChose)
        }
    }
}

// MARK: -

public protocol CheckBoxColorPalette {
    var checkboxBackground: Color { get }
    var checkboxCheckmark: Color { get }
}

// MARK: - Constants

extension CGFloat {

    static let size: Self = 20
    static let cornerRadius: Self = 4
    static let borderWidth: Self = 1
}
