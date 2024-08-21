//
//  FoodInfoScreenView.swift
//  MC3
//
//  Created by Leonardo Marhan on 21/08/24.
//

import SwiftUI

struct FoodInfoScreenView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Rujak Cingur Vegetarian Khas Surabaya Barat Daya")
                    .font(.custom("Lato-Bold", size: 32))
                Spacer()
                VStack {
                    HStack {
                        Circle()
                            .frame(width: 8)
                        Text("Safe")
                            .font(.custom("Lato-Regular", size: 15))
                    }
                    Spacer()
                }
                .foregroundColor(.greensuccess)
            }
            .frame(height: 120)
            HStack {
                Text("299gr/bowl")
                    .font(.custom("Lato-Light", size: 15))
                Spacer()
            }
            HStack {
                //Component dari jo
            }
            HStack {
                Text("NUTRIONAL INFO")
                    .font(.custom("Lato-Bold", size: 16))
                Spacer()
                Text("/serving")
                    .font(.custom("Lato-Light", size: 12))
            }
            .padding(.vertical)
            VStack {
                NutrientInfoComponentView(nutrientName: "Vitamin A", nutrientAmount: 30)
                NutrientInfoComponentView(nutrientName: "Vitamin D", nutrientAmount: 30)
                NutrientInfoComponentView(nutrientName: "Zinc", nutrientAmount: 30)
                NutrientInfoComponentView(nutrientName: "Iron", nutrientAmount: 30)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    FoodInfoScreenView()
}

