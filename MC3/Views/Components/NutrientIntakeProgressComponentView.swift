//
//  NutrientIntakeProgressComponentView.swift
//  MC3
//
//  Created by Jovanna Melissa on 20/08/24.
//

import SwiftUI

struct NutrientIntakeProgressComponentView: View {
    var nutrientName:String
    var nutrientIntake:Float
    var nutrientTarget:Float
    var nutrientUnit:String
    
    var body: some View {
        
        VStack{
            HStack{
                Text(nutrientName)
                    .fontWeight(.bold)
                    .font(.custom("Lato-Bold", size: 13))

                Spacer()
                
                Text("\(nutrientIntake, specifier: "%.0f")")
                    .font(.custom("Lato-Bold", size: 13))
                Text("/\(nutrientTarget, specifier: "%.0f")\(nutrientUnit)")
                    .font(.custom("Lato-Regular", size: 13))
            }
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: geometry.size.width, height: 15)
                        .foregroundColor(.yellowbg)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(
                            width: min(CGFloat((nutrientIntake / nutrientTarget)) * geometry.size.width,
                                       geometry.size.width),
                            height: 15
                        )
                        .foregroundColor(.yellowprimary)
                }
            }
        }
        
    }
}

#Preview {
    NutrientIntakeProgressComponentView(nutrientName: "Protein", nutrientIntake: 80, nutrientTarget: 200, nutrientUnit: "g")
}
