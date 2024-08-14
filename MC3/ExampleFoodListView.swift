//
//  ExampleFoodListView.swift
//  MC3
//
//  Created by mg0 on 14/08/24.
//

import SwiftUI

struct ExampleFoodListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var foods: [Food] = []
    
    var body: some View {
        List(foods) { food in
            HStack {
                Text(food.title)
                Spacer()
                Button(action: {
                    logFoodIntake(food: food)
                }) {
                    Text("Log Intake")
                }
            }
        }
        .onAppear(perform: loadFoods)
        .navigationTitle("Food List")
    }
    
    private func loadFoods() {
        foods = JSONLoader.loadFoods()
    }
    
    private func logFoodIntake(food: Food) {
        let newFoodIntake = FoodIntake(context: viewContext)
        newFoodIntake.intakeAt = Date()
        newFoodIntake.foodId = Int64(food.id)
        newFoodIntake.id = UUID()
        
        do {
            try viewContext.save()
            print("Food intake logged successfully")
        } catch {
            // Handle the error, e.g., show an alert
            print("Failed to save food intake: \(error.localizedDescription)")
        }
    }
}

struct ExampleFoodListView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleFoodListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
