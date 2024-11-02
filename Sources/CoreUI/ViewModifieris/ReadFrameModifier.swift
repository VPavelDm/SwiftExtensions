//
//  File.swift
//  
//
//  Created by Pavel Vaitsikhouski on 06.09.24.
//

import SwiftUI

private struct ReadFrameModifier: ViewModifier {

    @Binding var frame: CGRect
    var coordinateSpace: CoordinateSpace

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometryProxy in
                    Color.clear
                        .preference(key: FramePreferenceKey.self, value: geometryProxy.frame(in: coordinateSpace))
                }
            )
            .onPreferenceChange(FramePreferenceKey.self) { frame in
                self.frame = frame
            }
    }
}

private struct FramePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) { }
}

public extension View {

    func readSize(size: Binding<CGSize>) -> some View {
        modifier(ReadFrameModifier(
            frame: Binding(
                get: { CGRect(origin: .zero, size: size.wrappedValue) },
                set: { newValue in size.wrappedValue = newValue.size }
            ),
            coordinateSpace: .global
        ))
    }

    func readFrame(frame: Binding<CGRect>, coordinateSpace: CoordinateSpace = .local) -> some View {
        modifier(ReadFrameModifier(frame: frame, coordinateSpace: coordinateSpace))
    }
}
