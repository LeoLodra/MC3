//
//  WeightGauge.swift
//  MC3
//
//  Created by mg0 on 22/08/24.
//

import SwiftUI

struct WeightGauge: View {
    var value: Float
    var minValue: Float
    var maxValue: Float
    var tick1treshold: Float
    var tick2treshold: Float
    var tick3treshold: Float

    enum WeightStatus {
        case ideal
        case underweight
        case overweight
        case obese
    }

    @State private var animatedValue: Float

    init(value: Float, minValue: Float, maxValue: Float, tick1treshold: Float, tick2treshold: Float, tick3treshold: Float) {
        self.value = value
        self.minValue = minValue
        self.maxValue = maxValue
        self.tick1treshold = tick1treshold
        self.tick2treshold = tick2treshold
        self.tick3treshold = tick3treshold
        self._animatedValue = State(initialValue: value)
    }

    private var weightStatus: WeightStatus {
        if animatedValue < tick1treshold {
            return .underweight
        } else if animatedValue < tick2treshold {
            return .ideal
        } else if animatedValue < tick3treshold {
            return .overweight
        } else {
            return .obese
        }
    }
    private var tickLabelWidth: CGFloat {
        switch weightStatus {
            case .ideal:
                return 95
            case .underweight:
                return 130
            case .overweight:
                return 125
            case .obese:
                return 100
        }
    }
    private var underweightWidthModifier: Float {
        return (tick1treshold - minValue) / (maxValue - minValue)
    }
    private var normalweightWidthModifier: Float {
        return (tick2treshold - tick1treshold) / (maxValue - minValue)
    }
    private var overweightWidthModifier: Float {
        return (tick3treshold - tick2treshold) / (maxValue - minValue)
    }
    private var obeseWidthModifier: Float {
        return (maxValue - tick3treshold) / (maxValue - minValue)
    }
    private var calculatedWeightTickModifier: Float {
        return max(0, min(1, (animatedValue - minValue) / (maxValue - minValue)))
    }
    
    private let topOffset: CGFloat = 62
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                HStack (spacing: 0) {
                    Rectangle()
                        .fill(.orangewarning)
                        .frame(width: proxy.size.width * CGFloat(underweightWidthModifier))
                        .roundedCornerWithBorder(lineWidth: 2, borderColor: .clear, radius: 10, corners: [.topLeft, .bottomLeft])
                    Rectangle()
                        .fill(.greensuccess)
                        .frame(width: proxy.size.width * CGFloat(normalweightWidthModifier))
                    Rectangle()
                        .fill(.orangewarning)
                        .frame(width: proxy.size.width * CGFloat(overweightWidthModifier))
                    Rectangle()
                        .fill(.lightredwarning)
                        .frame(width: proxy.size.width * CGFloat(obeseWidthModifier))
                        .roundedCornerWithBorder(lineWidth: 2, borderColor: .clear, radius: 10, corners: [.topRight, .bottomRight])

                }
                .frame(height: 33)
                .offset(y: 10 + topOffset)
                /// Tick Label Group
                Group {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(width: tickLabelWidth, height: 62)
                        .shadow(radius: 1)
                        .overlay(
                            VStack (spacing: 0) {
                                HStack (alignment: .lastTextBaseline, spacing: 1) {
                                    Text("\(abs(animatedValue), specifier: animatedValue.truncatingRemainder(dividingBy: 1) == 0 ? "%.0f" : "%.1f")")
                                        .bold()
                                        .font(.system(size: 28))
                                        .contentTransition(.numericText(value: Double(animatedValue)))
                                        .animation(.linear(duration: 0.5), value: animatedValue)
                                    Text("KG")
                                        .font(.system(size: 15))
                                }
                                HStack (spacing: 4) {
                                    switch weightStatus {
                                    case .ideal:
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(.greensuccess)
                                            .font(.system(size: 8))
                                        Text("Ideal")
                                            .foregroundStyle(.greensuccess)
                                            .bold()
                                    case .underweight:
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(.orangewarning)
                                            .font(.system(size: 8))
                                        Text("Underweight")
                                            .foregroundStyle(.orangewarning)
                                            .bold()
                                    case .overweight:
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(.orangewarning)
                                            .font(.system(size: 8))
                                        Text("Overweight")
                                            .foregroundStyle(.orangewarning)
                                            .bold()
                                    case .obese:
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(.lightredwarning)
                                            .font(.system(size: 8))
                                        Text("Obese")
                                            .foregroundStyle(.lightredwarning)
                                            .bold()
                                    }
                                }
                            }
                        )
                        .offset(x: min(
                            proxy.size.width - tickLabelWidth,
                            max(
                                proxy.size.width * CGFloat(calculatedWeightTickModifier) - tickLabelWidth/2,
                                0
                            )
                        )
                        )
                    Circle()
                        .fill(.darkblueprimary)
                        .frame(width: 7)
                        .offset(x: -3.5, y: 2 + topOffset)
                        .offset(x: proxy.size.width * CGFloat(calculatedWeightTickModifier))
                    Capsule()
                        .fill(.darkblueprimary)
                        .frame(width: 2, height: 45)
                        .offset(x: -1, y: 5 + topOffset)
                        .offset(x: proxy.size.width * CGFloat(calculatedWeightTickModifier))
                }
                /// Threshold Indicator
                Group {
                    Text("\(tick1treshold, specifier: "%.0f")")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .offset(x: proxy.size.width *  CGFloat(underweightWidthModifier) - 6, y: 105)
                    Text("\(tick2treshold, specifier: "%.0f")")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .offset(x: proxy.size.width *  CGFloat(underweightWidthModifier + normalweightWidthModifier) - 6, y: 105)
                    Text("\(tick3treshold, specifier: "%.0f")")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .offset(x: proxy.size.width *  CGFloat(underweightWidthModifier + normalweightWidthModifier + overweightWidthModifier) - 6, y: 105)
                }
            }
            .frame(height: 125)
        }
        .gaugeStyle(.accessoryCircular)
        .onChange(of: value) { oldValue, newValue in
            withAnimation(.linear(duration: 0.5)) {
                animatedValue = newValue
            }
        }
        .onAppear {
            animatedValue = value
        }
    }
}


#Preview {
    WeightGauge(value: 48, minValue: 10, maxValue: 100, tick1treshold: 30, tick2treshold: 50, tick3treshold: 70)
}
