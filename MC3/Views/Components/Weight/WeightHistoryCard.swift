//
//  WeightHistoryCard.swift
//  MC3
//
//  Created by mg0 on 22/08/24.
//

import SwiftUI

struct WeightHistoryCard: View {
    let weeklyWeightEntries: [(xAxis: String, weight: Double)]
    let monthlyWeightEntries: [(xAxis: String, weight: Double)]
    @State private var selectedTimeframe: Timeframe = .weekly
    
    private var lastFiveWeeklyEntries: [(xAxis: String, weight: Double)] {
        Array(weeklyWeightEntries.suffix(5))
    }
    
    enum Timeframe: String, CaseIterable {
        case weekly = "Weekly"
        case monthly = "Monthly"
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            HStack {
                Text("Overview")
                    .font(.system(size: 19))
                    .fontWeight(.semibold)
            }
            Picker("Timeframe", selection: $selectedTimeframe) {
                ForEach(Timeframe.allCases, id: \.self) { timeframe in
                    Text(timeframe.rawValue).tag(timeframe)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            if selectedTimeframe == .weekly {
                WeightGraph(weightEntries: lastFiveWeeklyEntries)
            } else {
                WeightGraph(weightEntries: monthlyWeightEntries)
            }
            HStack {
                Text("Your weight gain shows throughout the time")
                    .font(.system(size: 13))
                    .foregroundStyle(.gray)
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 1)
        .padding(.horizontal)
    }
}
