//
//  FoodLogSheetComponentView.swift
//  MC3
//
//  Created by Jovanna Melissa on 20/08/24.
//

import SwiftUI

struct FoodLogSheetComponentView: View {
    @State private var foodLogDate = Date()
    @ObservedObject var vm:FoodLogViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var foodLogShowingSheet:Bool
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    HStack{
                        Text("Log Food")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(.blueprimary)
                            
                            Text("\(vm.tempFoodLog.count)")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                        }
                        .frame(width: 25, height: 25)
                    }
                    
                    Spacer()
                    
                    DatePicker("", selection: $foodLogDate, displayedComponents: [.date])
                }
                .padding()
                
                ForEach(vm.tempFoodLog){food in
                    FoodLogListCardComponentView(food: food, vm: vm)
                }
                
                Spacer()
                
                if vm.tempFoodLog.count != 0{
                    Button(action: {
                        vm.tempFoodLog.forEach { food in
                            logFoodIntake(food: food)
                        }
                        foodLogShowingSheet = false
                        vm.tempFoodLog.removeAll()
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 9999)
                                .foregroundStyle(.blueprimary)
                            Text("Save Food Intake")
                                .fontWeight(.semibold)
                        }
                        .frame(height: 50)
                        .foregroundStyle(.white)
                        .padding()
                    })
                }
            }
        }
    }
    
    private func logFoodIntake(food: foodIntakePortion) {
        let newFoodIntake = FoodIntake(context: viewContext)
        newFoodIntake.intakeAt = foodLogDate
        newFoodIntake.foodId = Int64(food.food.id)
        newFoodIntake.intakeAmount = Int64(food.portion)
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

//#Preview {
//    FoodLogSheetComponentView(foodPortion: <#Int#>)
//}
