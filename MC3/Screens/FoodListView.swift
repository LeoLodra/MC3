//
//  FoodListView.swift
//  MC3
//
//  Created by Jovanna Melissa on 18/08/24.
//

import SwiftUI

struct FoodListView: View {
    
    var body: some View {
        ScrollView{
            VStack{
                FoodCardViewComponent(foodName: "Pizza", foodStatus: "Restricted", foodCalorie: 300, foodServing: 500, foodProtein: 1, foodFolicAcid: 39, foodCalcium: 39)
                
                FoodCardViewComponent(foodName: "Martabak", foodStatus: "Limited Consumption", foodCalorie: 300, foodServing: 500, foodProtein: 1, foodFolicAcid: 39, foodCalcium: 39)
            }
        }
    }
}

#Preview {
    FoodListView()
}
