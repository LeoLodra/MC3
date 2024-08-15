//
//  NutrientDetailView.swift
//  MC3
//
//  Created by Jovanna Melissa on 15/08/24.
//

import SwiftUI

struct NutrientDetailView: View {
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Text("Hi " + "Ayu" + "!")
                Text("Let's see how far you've got")
            }
            .fontWeight(.bold)
            .font(.title)
            .frame(width: 390)
            .padding()
            
            DailyandWeeklyNutrientComponentView()
        }
        
    }
}

#Preview {
    NutrientDetailView()
}
