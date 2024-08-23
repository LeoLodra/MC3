//
//  GoalsScreenView.swift
//  MC3
//
//  Created by Leonardo Marhan on 13/08/24.
//

import SwiftUI

struct GoalsScreenView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \User.createdAt, ascending: false)],
        animation: .default)
    var users: FetchedResults<User>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WeightLog.logDate, ascending: false)]
    ) private var weightLogs: FetchedResults<WeightLog>
    
    /// Navigation
    @State private var navigateToProfile = false
    @State private var navigateToNutrientDetail = false
    @State private var isShowingWeightUpdateSheet = false
    @State private var isShowingWeightScreen = false
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack (alignment: .leading){
                    HStack {
                        Text("Hi ")
                            .font(.custom("Lato-Regular", size: 24))
                        +
                        Text("\(users.first?.fullName ?? "Mother")!")
                            .font(.custom("Lato-Bold", size: 24))
                        Spacer()
                        Button (action: {
                            navigateToProfile = true
                        }) {
                            
                            Image(systemName: "person.crop.circle")
                                .font(.system(size: 29))
                                .foregroundColor(.black)
                        }
                    }
                    Text("You're in ")
                        .font(.custom("Lato-Regular", size: 24))
                    +
                    Text("Week 3")
                        .font(.custom("Lato-Bold", size: 24))
                    
                    Group {
                        CaloriesNutrientView()
                    }
                    .onTapGesture(perform: {
                        navigateToNutrientDetail = true
                    })
                    .foregroundColor(.black)
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    WeightWidgetView()
                }
            }
            .padding()
            .background(
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
            )
            .navigationDestination(isPresented: $navigateToNutrientDetail) {
                NutrientDetailView()
            }
            .navigationDestination(isPresented: $navigateToProfile) {
                ProfileScreenView()
            }
            .navigationDestination(isPresented: $isShowingWeightScreen) {
                WeightScreenView()
            }
        }
    }
}

// MARK: Weight Widget
extension GoalsScreenView {
    func WeightWidgetView() -> some View {
        VStack(alignment: .leading) {
            Group {
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
                Text(lastUpdatedText)
                    .font(.system(size: 13))
                    .foregroundStyle(.gray)
            }
            .onTapGesture(perform: {
                isShowingWeightScreen = true
            })
            Button(action: {
                isShowingWeightScreen = true
                isShowingWeightUpdateSheet = true
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Update Weight")
                }
                .frame(maxWidth: .infinity, maxHeight: 9)
                .padding()
                .background(Color.blueprimary)
                .foregroundColor(.white)
                .cornerRadius(500)
            }
            .sheet(isPresented: $isShowingWeightUpdateSheet) {
                WeightUpdateSheet(value: currentState.newestWeight)
                    .environment(\.managedObjectContext, viewContext)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}


// MARK: Computed variables for weight
extension GoalsScreenView {
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


#Preview {
    GoalsScreenView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
