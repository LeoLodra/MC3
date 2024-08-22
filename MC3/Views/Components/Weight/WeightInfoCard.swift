//
//  WeightInfoCard.swift
//  MC3
//
//  Created by mg0 on 22/08/24.
//

import SwiftUI

/// Deprecated
struct WeightInfoCard: View {
    let title: String
    let value: Float
    let subtitle: String
    let isArrowable: Bool
    
    enum WeightState {
        case normal
        case overweight
        case underweight
    }
    
    init(title: String, value: Float, subtitle: String, isArrowable: Bool = false) {
        self.title = title
        self.value = value
        self.subtitle = subtitle
        self.isArrowable = isArrowable
    }
    
    private var state: WeightState {
        if isArrowable && value != 0 {
            return value > 0 ? .overweight : .underweight
        }
        return .normal
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(state == .overweight ? Color.red.opacity(0.2) : (state == .underweight ? Color.yellow.opacity(0.2) : Color.gray.opacity(0)))
                .frame(height: 80)
                .overlay(
                    VStack(alignment: .center, spacing: 4) {
                        if state != .normal {
                            HStack(spacing: 2) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(state == .overweight ? .red : .yellow)
                                Text(title)
                                    .font(.caption)
                            }
                        } else {
                            Text(title)
                                .font(.caption)
                        }
                        
                        if isArrowable && state != .normal {
                            HStack(spacing: 2) {
                                Image(systemName: state == .overweight ? "arrow.up" : "arrow.down")
                                Text("\(abs(value), specifier: value.truncatingRemainder(dividingBy: 1) == 0 ? "%.0f" : "%.1f") kg")
                            }
                            .font(.title2)
                            .fontWeight(.bold)
                        } else {
                            Text("\(abs(value), specifier: value.truncatingRemainder(dividingBy: 1) == 0 ? "%.0f" : "%.1f") kg")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        Text(subtitle)
                            .font(.caption)
                    }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                )
        }
    }
}

