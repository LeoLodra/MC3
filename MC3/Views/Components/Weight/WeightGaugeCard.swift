//
//  WeightGaugeCard.swift
//  MC3
//
//  Created by mg0 on 22/08/24.
//

import SwiftUI

struct WeightGaugeCard: View {
    let title: String = "Weight"
    let value: Float
    let minValue: Float
    let maxValue: Float
    let tick1threshold: Float
    let tick2threshold: Float
    let tick3threshold: Float
    let weekNumber: Int
    let lastUpdated: Date
    var showChevron: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
                HStack (alignment: .firstTextBaseline) {
                    Text("Week \(weekNumber)")
                        .font(.system(size: 16))
                        .fontWeight(.light)
                    if showChevron {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.blueprimary)
                    }
                }
            }
            WeightGauge(value: value, minValue: minValue, maxValue: maxValue, tick1treshold: tick1threshold, tick2treshold: tick2threshold, tick3treshold: tick3threshold)
            Text(lastUpdatedText)
                .font(.system(size: 13))
                .foregroundStyle(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 1)
        .padding()
    }
    
    private var lastUpdatedText: String {
        let calendar = Calendar.current
        let now = Date()
        if calendar.isDateInToday(lastUpdated) {
            return "Last updated today"
        } else {
            let days = calendar.dateComponents([.day], from: lastUpdated, to: now).day ?? 0
            return "Last updated \(days) day\(days == 1 ? "" : "s") ago"
        }
    }
}


#Preview {
    WeightGaugeCard(value: 48, minValue: 10, maxValue: 100, tick1threshold: 20, tick2threshold: 50, tick3threshold: 70, weekNumber: 10, lastUpdated: Date())
}
