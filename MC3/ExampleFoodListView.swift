//
//  ExampleFoodListView.swift
//  MC3
//
//  Created by mg0 on 14/08/24.
//

import SwiftUI

struct ExampleFoodListView: View {
    @State private var foods: [Food] = []

    var body: some View {
        List(foods) { food in
            Text(food.title)
        }
        .onAppear(perform: loadFoods)
        .navigationTitle("Food List")
    }

    private func loadFoods() {
        foods = JSONLoader.loadFoods()
    }
}

struct ExampleFoodListView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleFoodListView()
    }
}
