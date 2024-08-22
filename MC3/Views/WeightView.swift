//
//  WeightView.swift
//  MC3
//
//  Created by Leonardo Marhan on 21/08/24.
//

import SwiftUI

struct WeightView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \WeightLog.logDate, ascending: false)]
//    )
//    private var weightLogs: FetchedResults<WeightLog>
    
    let title: String = "Weight"
    let value: Float
    let minValue: Float
    let maxValue: Float
    let tick1threshold: Float
    let tick2threshold: Float
    let tick3threshold: Float
    let weekNumber: Int
    let lastUpdated: Date
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(.white)
            VStack(alignment: .leading) {
                HStack {
                    Text("Weight")
                        .font(.custom("Lato-Bold", size: 24))
                    Spacer()
                    Text("Week \(weekNumber)")
                        .font(.custom("Lato-Regular", size: 17))
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 24))
                        .foregroundColor(.blueprimary)
                }
                WeightGauge(value: value, minValue: minValue, maxValue: maxValue, tick1treshold: tick1threshold, tick2treshold: tick2threshold, tick3treshold: tick3threshold)
                Text("\(lastUpdatedText)")
                    .font(.custom("Lato-Regular", size: 13))
                NavigationLink(destination: NutrientDetailView()) {
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
            }
            .padding(.horizontal, 17)
            .padding(.vertical, 18)
        }
        .frame(width: 361, height: 247)
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
    WeightView(value: 1, minValue: 2, maxValue: 2, tick1threshold: 1, tick2threshold: 2, tick3threshold: 2, weekNumber: 2, lastUpdated: Date())
}
