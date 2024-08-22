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

    // Current state
    private var currentState: (weekNumber: Int, lastUpdated: Date, newestWeight: Float) {
        let calendar = Calendar.current
        let currentDate = Date()
        let weekNumber = calendar.dateComponents([.weekOfYear], from: user?.lastHaidAt ?? currentDate, to: currentDate).weekOfYear ?? 0
        let lastUpdated = weightLogs.first?.logDate ?? currentDate
        let newestWeight = weightLogs.first?.weight ?? 0
        
        return (weekNumber, lastUpdated, newestWeight)
    }

    #warning("TODO: Calculate the ideal weight")
    let gaugeMinValue = 30
    let gaugeMaxValue = 80
    let gaugeTick1Threshold = 40
    let gaugeTick2Threshold = 60
    let gaugeTick3Threshold = 70
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 0) {
                WeightGaugeCard(value: Float(currentState.newestWeight), minValue: Float(gaugeMinValue), maxValue: Float(gaugeMaxValue), tick1threshold: Float(gaugeTick1Threshold), tick2threshold: Float(gaugeTick2Threshold), tick3threshold: Float(gaugeTick3Threshold), weekNumber: currentState.weekNumber, lastUpdated: currentState.lastUpdated, showChevron: false)
                WeightHistoryCard(weeklyWeightEntries: weeklyWeightEntries, monthlyWeightEntries: monthlyWeightEntries)
                Spacer()
                AddWeightButton(action: {
                    let weightUpdateSheet = WeightUpdateSheet(value: currentState.newestWeight).environment(\.managedObjectContext, viewContext)
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let window = windowScene.windows.first {
                        let hostingController = UIHostingController(rootView: weightUpdateSheet)
                        hostingController.modalPresentationStyle = .pageSheet
                        
                        if let sheet = hostingController.sheetPresentationController {
                            sheet.detents = [.medium()]
                            sheet.prefersGrabberVisible = true
                        }
                        
                        window.rootViewController?.present(hostingController, animated: true, completion: nil)
                    }
                })
            }
            .navigationTitle("Your Weight")
        }
    }
}

// MARK: Computer variables
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
}

#Preview {
    WeightScreenView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

