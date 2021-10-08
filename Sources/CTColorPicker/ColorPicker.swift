//
//  ColorPicker.swift
//  CTColorPicker
//
//  Created by 和泉田 領一 on 2019/08/03.
//

import SwiftUI
#if canImport(Combine)
import Combine
#endif

@available(OSX 10.15, iOS 13.0, *)
public struct ColorPicker: View {
    private let squareScale: CGFloat
    private let model: ColorPickerModel
    private var cancellables = Set<AnyCancellable>()

    public init(color: UIColor = .white, squareScale: CGFloat = 0.8, onChange: @escaping (UIColor) -> ()) {
        self.squareScale = squareScale
        self.model = ColorPickerModel(color: color)
        model.objectWillChange.sink(receiveValue: onChange).store(in: &cancellables)
    }

    public var body: some View {
        VStack {
            GeometryReader { geometry in
                HCircle(scale: self.squareScale)
                    .overlay(
                        SBSquare(scale: 1.0)
                            .frame(width: geometry.size.width * 0.55, height: geometry.size.width * 0.55)
                            .background(Color.green),
                        alignment: .center
                    )
                    .frame(width: getLength(geometry),
                           height: getLength(geometry),
                           alignment: .center)
            }
        }.environmentObject(model)
    }
}

#if DEBUG
@available(OSX 10.15, iOS 13.0, *)
struct ColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        ColorPicker { _ in }
    }
}
#endif
