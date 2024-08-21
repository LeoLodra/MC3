//
//  WeightView.swift
//  MC3
//
//  Created by Leonardo Marhan on 21/08/24.
//

import SwiftUI

struct WeightView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(.white)
            VStack(alignment: .leading) {
                HStack {
                    Text("Weight")
                        .font(.custom("Lato-Bold", size: 24))
                    Spacer()
                    Text("Week 3")
                        .font(.custom("Lato-Regular", size: 17))
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 24))
                        .foregroundColor(.blueprimary)
                }
//                WeightGaugeCard(value: Float(currentState.newestWeight), minValue: Float(gaugeMinValue), maxValue: Float(gaugeMaxValue), tick1threshold: Float(gaugeTick1Threshold), tick2threshold: Float(gaugeTick2Threshold), tick3threshold: Float(gaugeTick3Threshold), weekNumber: currentState.weekNumber, lastUpdated: currentState.lastUpdated, showChevron: false)
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
                .padding(.horizontal)
            }
            .padding(.horizontal, 17)
            .padding(.vertical, 18)
        }
        .frame(width: 361, height: 247)
    }
}

#Preview {
    WeightView()
}
