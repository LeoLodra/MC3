//
//  NutrientInfoComponentView.swift
//  MC3
//
//  Created by Leonardo Marhan on 21/08/24.
//

import SwiftUI

struct NutrientInfoComponentView: View {
    var nutrientName: String
    var nutrientAmount: Float
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
                .foregroundColor(.yellowbg)
            HStack {
                ZStack {
                    RoundedRectangle(cornerSize: CGSize(width: 6, height: 6))
                        .frame(width: 75, height: 36)
                    .foregroundColor(.yellowprimary)
                    Text(String(nutrientAmount) + "mg")
                        .font(.custom("Lato-Regular", size: 17))
                }
                .padding(.horizontal, 8)
                Text(nutrientName)
                    .font(.custom("Lato-Bold", size: 17))
                Spacer()
            }
        }
        .frame(width: 361, height: 52)
    }
}

#Preview {
    NutrientInfoComponentView(nutrientName: "Vitamin A", nutrientAmount: 30)
}
