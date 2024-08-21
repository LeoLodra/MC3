//
//  CaloriesNutrientView.swift
//  MC3
//
//  Created by Leonardo Marhan on 21/08/24.
//

import SwiftUI

struct CaloriesNutrientView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(.white)
            VStack(alignment: .leading) {
                HStack {
                    Text("Today's Goals")
                        .font(.custom("Lato-Bold", size: 24))
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 24))
                        .foregroundColor(.blueprimary)
                }
                HStack {
                    NutrientRingComponentView(nutrientName: "Calories", nutrientTarget: 2357, nutrientIntake: 880, nutrientUnit: "Kcal")
                        .frame(width: 130)
                    Spacer()
                    VStack {
                        NutrientIntakeProgressComponentView(nutrientName: "Protein", nutrientIntake: 880, nutrientTarget: 2357, nutrientUnit: "mg")
                        NutrientIntakeProgressComponentView(nutrientName: "Folic Acid", nutrientIntake: 880, nutrientTarget: 2357, nutrientUnit: "mg")
                        NutrientIntakeProgressComponentView(nutrientName: "Calcium", nutrientIntake: 880, nutrientTarget: 2357, nutrientUnit: "mg")
                    }
                    .frame(width: 160)
                }
                Spacer()
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 328, height: 1)
                    .background(Color(red: 0.5, green: 0.5, blue: 0.5).opacity(0.2))
                Text("Your Last Food")
                    .font(.custom("Lato-Bold", size: 17))
                //Component dari Jo
                NavigationLink(destination: FoodListView()) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Food Log")
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
        .frame(width: 361, height: 423)
    }
}

#Preview {
    CaloriesNutrientView()
}
