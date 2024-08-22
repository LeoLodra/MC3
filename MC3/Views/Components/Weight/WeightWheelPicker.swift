//
//  WeightWheelPicker.swift
//  MC3
//
//  Created by mg0 on 21/08/24.
//

import SwiftUI

struct WeightWheelPicker: View {
    var config: Config
    @Binding var value: Float
    /// View Properties
    @State var isLoaded: Bool = false
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let horizontalPadding = size.width / 2

            ScrollView(.horizontal) {
                HStack(spacing: config.spacing) {
                    let totalSteps = config.count * config.steps 

                    ForEach(0..<totalSteps, id: \.self) { index in
                        let remainder = index % config.steps

                        Divider()
                            .background(remainder == 0 ? Color.primary: .gray)
                            .frame(width: 0, height: remainder == 0 ? 20: 10, alignment: .center)
                            .frame(maxHeight: 20, alignment: .bottom)
                            .overlay(alignment: .bottom) {
                                if remainder == 0 && config.showsText {
                                    Text("\((index / config.steps) * config.multiplier)")
                                        .font(.system(size: 10, weight: .semibold))
                                        .textScale(.secondary)
                                        .fixedSize()
                                        .offset(y: 20)
                                }
                            }
                    }
                }
                .frame(height: size.height)
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: .init(get: {
                let position: Int? = isLoaded ? (Int(value) * config.steps) / config.multiplier : nil
                return position
            }, set: { newValue in
                if let newValue {
                    value = Float(newValue)/Float(config.steps) * Float(config.multiplier)
                }
            }))
            .overlay(alignment: .center, content: {
                Rectangle()
                    .frame(width: 1, height: 40)
                    .padding(.bottom, 20)
            })
            .safeAreaPadding(.horizontal, horizontalPadding)
            .onAppear {
                if !isLoaded { isLoaded = true }
            }
        }
    }
    
    struct Config: Equatable {
        var count: Int = 50
        var steps: Int = 10
        var spacing: CGFloat = 5
        var showsText: Bool = true
        var multiplier: Int = 1
    }
}

#Preview {
    WeightUpdateSheet()
}
