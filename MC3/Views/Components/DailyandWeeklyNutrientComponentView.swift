//
//  DailyandWeeklyNutrientComponentView.swift
//  MC3
//
//  Created by Jovanna Melissa on 15/08/24.
//

import SwiftUI

struct DailyandWeeklyNutrientComponentView: View {
    @State private var period = 0
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.yellowbg)
            
            VStack{
                Picker("", selection: $period) {
                    Text("Daily").tag(0)
                    Text("Weekly").tag(1)
                }
                .pickerStyle(.segmented)
                
                Spacer()
                
                HStack{
                    Image(systemName: "chevron.left")
                    Text("Thursday, 15 Aug")
                        .fontWeight(.semibold)
                    Image(systemName: "chevron.right")
                }
            }
            .padding()
        }
        .padding()
        .frame(height: 100)
    }
}

#Preview {
    DailyandWeeklyNutrientComponentView()
}
