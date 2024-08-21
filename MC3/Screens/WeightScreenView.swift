//
//  WeightScreenView.swift
//  MC3
//
//  Created by mg0 on 19/08/24.
//

import SwiftUI

struct WeightScreenView: View {
    @Environment(\.managedObjectContext) private var viewContext
    #warning("Get Data")
    let weeklyWeightEntries: [(xAxis: String, weight: Double)] = [
        ("1", 50.5),
        ("2", 49.4),
        ("3", 50.8),
        ("4", 51.5),
        ("5", 51.2),
        ("6", 51.9),
        ("7", 52.5),
        ("8", 52.2),
        ("9", 52.9),
        ("10", 53.5),
        ("11", 53.2),
        ("12", 53.9),
    ]
    let monthlyWeightEntries: [(xAxis: String, weight: Double)] = [
        ("Jan", 50.5),
        ("Feb", 50.4),
        ("Mar", 50.8),
        ("Apr", 51.5),
        ("May", 51.5),
        ("Jun", 58),
    ]

    #warning("Calculate the ideal weight and fetch the newest weight")
    let newestWeight = 50
    let gaugeMinValue = 30
    let gaugeMaxValue = 80
    let gaugeTick1Threshold = 40
    let gaugeTick2Threshold = 60
    let gaugeTick3Threshold = 70
    let weekNumber = 3
    let lastUpdated = Date()    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 0) {
                // HStack {
                //     WeightInfoCard(title: "Current", value: 47, subtitle: "1 Aug 2024")
                //     WeightInfoCard(title: "Gain", value: 3, subtitle: "last week: 42 kg", isArrowable: true)
                //     WeightInfoCard(title: "Gain Goal", value: 3, subtitle: "Week 3")
                // }
                // .padding(.top)
                WeightGaugeCard(value: Float(newestWeight), minValue: Float(gaugeMinValue), maxValue: Float(gaugeMaxValue), tick1threshold: Float(gaugeTick1Threshold), tick2threshold: Float(gaugeTick2Threshold), tick3threshold: Float(gaugeTick3Threshold), weekNumber: weekNumber, lastUpdated: lastUpdated, showChevron: false)
                WeightHistoryCard(weeklyWeightEntries: weeklyWeightEntries, monthlyWeightEntries: monthlyWeightEntries)
                Spacer()
                AddWeightButton(action: {
                    #warning("Pass initial value here")
                    let weightUpdateSheet = WeightUpdateSheet(value: 50).environment(\.managedObjectContext, viewContext)
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

struct AddWeightButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("Update Weight")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blueprimary)
            .foregroundColor(.white)
            .cornerRadius(500)
        }
        .padding(.horizontal)
    }
}

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
                #warning("Ask about this")
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

struct WeightGraph: View {
    let weightEntries: [(xAxis: String, weight: Double)]
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let height = proxy.size.height
            let maxWeight = (weightEntries.map { $0.weight }.max() ?? 0) + 2
            let minWeight = (weightEntries.map { $0.weight }.min() ?? 0) - 2
            let weightRange = maxWeight - minWeight
            
            ZStack {
                // Y-axis
                Path { path in
                    path.move(to: CGPoint(x: 40, y: 0))
                    path.addLine(to: CGPoint(x: 40, y: height - 20))
                }
                .stroke(Color.gray, lineWidth: 1)
                
                // X-axis
                Path { path in
                    path.move(to: CGPoint(x: 40, y: height - 20))
                    path.addLine(to: CGPoint(x: width, y: height - 20))
                }
                .stroke(Color.gray, lineWidth: 1)
                
                // Weight line
                Path { path in
                    let pointSpacing = (width - 60) / CGFloat(weightEntries.count - 1)
                    
                    for (index, weightData) in weightEntries.enumerated() {
                        let x = 50 + CGFloat(index) * pointSpacing
                        let y = height - 20 - (CGFloat(weightData.weight - minWeight) / CGFloat(weightRange)) * (height - 40)
                        
                        if index == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                }
                .stroke(Color.blueprimary, lineWidth: 2)
                
                // Data points
                ForEach(weightEntries.indices, id: \.self) { index in
                    let weightData = weightEntries[index]
                    let pointSpacing = weightEntries.count > 1 ? (width - 60) / CGFloat(weightEntries.count - 1) : 0
                    let x = pointSpacing > 0 ? 50 + CGFloat(index) * pointSpacing : (proxy.size.width / 2 + 20)
                    let y = height - 20 - (CGFloat(weightData.weight - minWeight) / CGFloat(weightRange)) * (height - 40)
                    
                    Circle()
                        .fill(.blueprimary)
                        .frame(width: 8, height: 8)
                        .position(x: x, y: y)
                    
                    // X-axis labels
                    Text("\(weightData.xAxis)")
                        .font(.caption)
                        .position(x: x, y: height - 5)
                    
                    // Weight labels
                    Text(String(format: "%.1f", weightData.weight))
                        .font(.caption)
                        .position(x: x, y: y - 15)
                }
                
                // Y-axis labels
                VStack(alignment: .trailing, spacing: (height - 100) / 4) {
                    ForEach(0...4, id: \.self) { i in
                        Text(String(format: "%.1f", minWeight + (weightRange / 4) * Double(4 - i)))
                            .font(.caption)
                    }
                }
                .position(x: 20, y: height / 2)
            }
        }
        .frame(height: 200)
    }
}

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

    private var weightStatus: WeightStatus {
        if value < tick1treshold {
            return .underweight
        } else if value < tick2treshold {
            return .ideal
        } else if value < tick3treshold {
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
        return max(0, min(1, (value - minValue) / (maxValue - minValue)))
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
                                    Text("\(abs(value), specifier: value.truncatingRemainder(dividingBy: 1) == 0 ? "%.0f" : "%.1f")")
                                        .bold()
                                        .font(.system(size: 28))
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
    }
}

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

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func roundedCornerWithBorder(lineWidth: CGFloat, borderColor: Color, radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
            .overlay(RoundedCorner(radius: radius, corners: corners)
                .stroke(borderColor, lineWidth: lineWidth))
    }
}

#Preview {
    WeightScreenView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
