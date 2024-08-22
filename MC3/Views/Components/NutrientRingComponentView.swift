//
//  NutrientRingComponentView.swift
//  MC3
//
//  Created by Jovanna Melissa on 20/08/24.
//

import SwiftUI

struct NutrientRingComponentView: View {
    var nutrientName:String
    var nutrientTarget:Float
    var nutrientIntake:Float
    var nutrientUnit:String
    @State private var statusColor = Color.blueprimary
    
    var body: some View {
        VStack{
            ZStack {
                Circle()
                    .stroke(
                        statusColor.opacity(0.5),
                        lineWidth: 20
                    )
                Circle()
                    .trim(from: 0, to: CGFloat((nutrientIntake / nutrientTarget)))
                    .stroke(
                        statusColor,
                        style: StrokeStyle(
                            lineWidth: 20,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: nutrientIntake / nutrientTarget)
                
                Text(nutrientName)
                    .font(.custom("Lato-Bold", size: 17))
                    .foregroundStyle(.darkgraytext)
            }
//            .frame(width: 180, height: 180)
            
            Text("**\(nutrientIntake, specifier: "%.0f")**  /\(nutrientTarget, specifier: "%.0f") \(nutrientUnit)")
                .padding(.top)
        }
        .onAppear(perform: {
            determineRingColor()
        })
    }
    
    private func determineRingColor(){
        if nutrientIntake < nutrientTarget{
            statusColor = .blueprimary
        } else if nutrientIntake == nutrientTarget{
            statusColor = .greensuccess
        } else {
            statusColor = .redwarning
        }
    }
}

#Preview {
    NutrientRingComponentView(nutrientName: "Calories", nutrientTarget: 2257, nutrientIntake: 2256, nutrientUnit: "Kcal")
}
