//
//  WeightScreenView.swift
//  MC3
//
//  Created by mg0 on 19/08/24.
//

import SwiftUI

struct WeightScreenView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WeightLog.logDate, ascending: false)]
    ) private var weightLogs: FetchedResults<WeightLog>
    
    @FetchRequest(
        sortDescriptors: []
    ) private var users: FetchedResults<User>
    @State private var isShowingWeightUpdateSheet = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 0) {
                WeightGaugeCard(value: Float(currentState.newestWeight), minValue: Float(gaugeMinValue), maxValue: Float(gaugeMaxValue), tick1threshold: Float(gaugeTick1Threshold), tick2threshold: Float(gaugeTick2Threshold), weekNumber: currentState.weekNumber, lastUpdated: currentState.lastUpdated, showChevron: false)
                WeightHistoryCard(weeklyWeightEntries: weeklyWeightEntries, monthlyWeightEntries: monthlyWeightEntries)
                Spacer()
                AddWeightButton(action: {
                    isShowingWeightUpdateSheet = true
                })
            }
            .navigationTitle("Your Weight")
            .sheet(isPresented: $isShowingWeightUpdateSheet) {
                WeightUpdateSheet(value: currentState.newestWeight)
                    .environment(\.managedObjectContext, viewContext)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

// MARK: Computed variables
extension WeightScreenView {
    private var user: User? {
        users.first
    }
    
    private var weeklyWeightEntries: [(xAxis: String, weight: Double)] {
        let calendar = Calendar.current
        guard let lastHaidAt = user?.lastHaidAt else { return [] }
        let groupedByWeek = Dictionary(grouping: weightLogs) { log in
            calendar.dateComponents([.weekOfYear], from: lastHaidAt, to: log.logDate ?? Date())
        }
        return groupedByWeek.values.compactMap { logs in
            guard let latestLog = logs.first else { return nil }
            let weekNumber = calendar.dateComponents([.weekOfYear], from: lastHaidAt, to: latestLog.logDate ?? Date()).weekOfYear ?? 0
            return ("\(weekNumber)", Double(latestLog.weight))
        }.sorted { Int($0.xAxis) ?? 0 < Int($1.xAxis) ?? 0 }
    }
    
    private var monthlyWeightEntries: [(xAxis: String, weight: Double)] {
        let calendar = Calendar.current
        let groupedByMonth = Dictionary(grouping: weightLogs) { log in
            calendar.dateComponents([.month, .year], from: log.logDate ?? Date())
        }
        return groupedByMonth.map { (key, logs) in
            let monthNumber = key.month ?? 0
            let monthName = calendar.shortMonthSymbols[monthNumber - 1]
            let averageWeight = logs.reduce(0.0) { $0 + Double($1.weight) } / Double(logs.count)
            return ("\(monthName)", averageWeight)
        }.sorted { (entry1, entry2) -> Bool in
            let components1 = entry1.xAxis.components(separatedBy: " ")
            let components2 = entry2.xAxis.components(separatedBy: " ")
            let year1 = Int(components1.last ?? "") ?? 0
            let year2 = Int(components2.last ?? "") ?? 0
            if year1 != year2 {
                return year1 < year2
            }
            let monthIndex1 = calendar.shortMonthSymbols.firstIndex(of: components1.first ?? "") ?? 0
            let monthIndex2 = calendar.shortMonthSymbols.firstIndex(of: components2.first ?? "") ?? 0
            return monthIndex1 < monthIndex2
        }
    }

    // Current state
    private var currentState: (weekNumber: Int, lastUpdated: Date, newestWeight: Float) {
        let calendar = Calendar.current
        let currentDate = Date()
        let weekNumber = calendar.dateComponents([.weekOfYear], from: user?.lastHaidAt ?? currentDate, to: currentDate).weekOfYear ?? 0
        let lastUpdated = weightLogs.first?.logDate ?? currentDate
        let newestWeight = weightLogs.first?.weight ?? 0
        
        return (weekNumber, lastUpdated, newestWeight)
    }
    
    
    // Calculate the ideal weight range using WeightGainCalculator
    private var idealWeightRange: WeightGainCalculator.WeightGainRange {
        guard let user = user else { return WeightGainCalculator.WeightGainRange(min: 0, max: 0) }
        return WeightGainCalculator.calculateWeightGainRange(
            weight: user.weight,
            height: Int(user.height),
            weeks: currentState.weekNumber,
            isTwins: user.fetusCount > 1
        )
    }
    
    private var gaugeMinValue: Float {
        guard let user = user else { return 0 }
        return Float(idealWeightRange.min) + user.weight - Float(idealWeightRange.max - idealWeightRange.min) / 2
    }
    private var gaugeMaxValue: Float {
        guard let user = user else { return 0 }
        return Float(idealWeightRange.max) + user.weight + Float(idealWeightRange.max - idealWeightRange.min) / 2
    }
    private var gaugeTick1Threshold: Float {
        guard let user = user else { return 0 }
        return Float(idealWeightRange.min) + user.weight
    }
    private var gaugeTick2Threshold: Float {
        guard let user = user else { return 0 }
        return Float(idealWeightRange.max) + user.weight
    }
}

#Preview {
    WeightScreenView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
