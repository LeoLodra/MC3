//
//  WeightGraph.swift
//  MC3
//
//  Created by mg0 on 22/08/24.
//

import SwiftUI


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

#Preview {
    WeightGraph(weightEntries: [("Hi", 1), ("Hi again", 2), ("bye", -3)])
}
