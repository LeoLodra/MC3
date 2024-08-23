//
//  WeightView.swift
//  MC3
//
//  Created by Leonardo Marhan on 21/08/24.
//

import SwiftUI

struct WeightView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WeightLog.logDate, ascending: false)]
    ) private var weightLogs: FetchedResults<WeightLog>
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \User.createdAt, ascending: false)],
        animation: .default)
    var users: FetchedResults<User>
    
    private var user: User? {
        users.first
    }
    
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
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(.white)
            VStack(alignment: .leading) {
                HStack {
                    Text("Weight")
                        .font(.custom("Lato-Bold", size: 24))
                    Spacer()
                    Text("Week \(currentState.weekNumber)")
                        .font(.custom("Lato-Regular", size: 17))
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 24))
                        .foregroundColor(.blueprimary)
                }
                WeightGauge(value: Float(currentState.newestWeight), minValue: Float(gaugeMinValue), maxValue: Float(gaugeMaxValue), tick1treshold: Float(gaugeTick1Threshold), tick2treshold: Float(gaugeTick2Threshold))
                Text("\(lastUpdatedText)")
                    .font(.custom("Lato-Regular", size: 13))
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
            .padding(.horizontal, 17)
            .padding(.vertical, 18)
        }
        .frame(width: 361, height: 247)
    }
    
    private var lastUpdatedText: String {
        let calendar = Calendar.current
        let now = Date()
        if calendar.isDateInToday(currentState.lastUpdated) {
            return "Last updated today"
        } else {
            let days = calendar.dateComponents([.day], from: currentState.lastUpdated, to: now).day ?? 0
            return "Last updated \(days) day\(days == 1 ? "" : "s") ago"
        }
    }
}
