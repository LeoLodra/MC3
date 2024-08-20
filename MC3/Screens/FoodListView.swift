//
//  FoodListView.swift
//  MC3
//
//  Created by Jovanna Melissa on 18/08/24.
//

import SwiftUI

struct FoodListView: View {
    
    @State private var foods:[Food] = []
    
    var body: some View {
        ScrollView{
            VStack(spacing: -16){
                ForEach(foods){food in
                    FoodCardViewComponent(food: food)
                }
            }
        }
        .onAppear(perform: {
            loadFoods()
        })
    }
    
    private func loadFoods() {
        foods = JSONLoader.loadFoods()
    }
}

#Preview {
    FoodListView()
}
