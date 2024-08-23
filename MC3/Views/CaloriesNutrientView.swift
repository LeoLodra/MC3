//
//  CaloriesNutrientView.swift
//  MC3
//
//  Created by Leonardo Marhan on 21/08/24.
//

import SwiftUI

struct CaloriesNutrientView: View {
    @State private var viewDate = Date()
    @State private var viewTrimester = 1
    @State private var foodIntakes: [FoodIntake] = []
    @State private var eatenFoods: [Food] = []
    @State private var latestEatenFood: Food? = nil
    @State private var latestIntakeAmount: Int = 0
    @State private var vm = NutrientTargetViewModel()
    @State private var nutrientTargets: [NutrientDailyTarget] = []
    @Environment(\.managedObjectContext) private var viewContext
    
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
                    NutrientRingComponentView(nutrientName: "Calories", nutrientTarget: viewTrimester == 1 ? 2430 : 2550, nutrientIntake: Float(getTotalCalories(foodLogDate: viewDate)), nutrientUnit: "Kcal", caloriesLabelSize: 17)
                        .frame(width: 130)
                    Spacer()
                    VStack {
                        ForEach(nutrientTargets) { target in
                            if target.trimester != nil && target.trimester == viewTrimester || target.trimester == nil {
                                if target.id <= 5 {
                                    NutrientIntakeProgressComponentView(nutrientName: target.nutrientName, nutrientIntake: Float(getTotalNutrients(nutrientID: target.id)), nutrientTarget: target.nutrientTarget, nutrientUnit: target.nutrientUnit)
                                        .padding(.bottom)
                                }
                            }
                        }
                    }
                    .frame(width: 160)
                }
                Spacer()
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 328, height: 1)
                    .background(Color(red: 0.5, green: 0.5, blue: 0.5).opacity(0.2))
                Spacer()
                Text("Your Last Food")
                    .font(.custom("Lato-Bold", size: 17))
                
                if let food = latestEatenFood {
                    LastEatenComponentView(food: food, intakeAmount: latestIntakeAmount)
                } else {
                    Text("No food eaten yet today")
                        .font(.custom("Lato-Regular", size: 15))
                        .foregroundColor(.gray)
                }
                
                Spacer()
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
            }
            .padding(.horizontal, 17)
            .padding(.vertical, 18)
        }
        .frame(width: 361, height: 420)
        .onAppear(perform: {
            nutrientTargets = vm.populateNutrientTargetData()
            foodIntakes = vm.fetchFoodIntake(foodLogDate: viewDate, viewContext: viewContext)
            eatenFoods = vm.getEatenFood(foodIntakes: foodIntakes)
            
            if let latestIntake = foodIntakes.last {
                latestEatenFood = eatenFoods.first(where: { $0.id == latestIntake.foodId })
                latestIntakeAmount = Int(latestIntake.intakeAmount)
            }
        })
        .onChange(of: viewDate) { _ in
            nutrientTargets.removeAll()
            foodIntakes.removeAll()
            eatenFoods.removeAll()
            
            nutrientTargets = vm.populateNutrientTargetData()
            foodIntakes = vm.fetchFoodIntake(foodLogDate: viewDate, viewContext: viewContext)
            eatenFoods = vm.getEatenFood(foodIntakes: foodIntakes)
            
            if let latestIntake = foodIntakes.last {
                latestEatenFood = eatenFoods.first(where: { $0.id == latestIntake.foodId })
                latestIntakeAmount = Int(latestIntake.intakeAmount)
            }
        }
    }
    
    private func getTotalCalories(foodLogDate: Date) -> Int {
        var calorieTotal = 0
        
        for intake in foodIntakes {
            for food in eatenFoods {
                if intake.foodId == food.id {
                    calorieTotal += (food.calories * Int(intake.intakeAmount))
                }
            }
        }
        
        return calorieTotal
    }
    
    private func getTotalNutrients(nutrientID: Int) -> Int {
        var nutrientTotal = 0
        
        for intake in foodIntakes {
            for food in eatenFoods {
                if intake.foodId == food.id {
                    if nutrientID == 1 || nutrientID == 2 || nutrientID == 3 {
                        nutrientTotal += (Int(food.protein) * Int(intake.intakeAmount))
                    } else if nutrientID == 4 {
                        nutrientTotal += (Int(food.folate) * Int(intake.intakeAmount))
                    } else if nutrientID == 5 {
                        nutrientTotal += (Int(food.calcium) * Int(intake.intakeAmount))
                    } else if nutrientID == 7 {
                        nutrientTotal += (Int(food.vitaminA) * Int(intake.intakeAmount))
                    } else if nutrientID == 8 {
                        nutrientTotal += (Int(food.vitaminD) * Int(intake.intakeAmount))
                    } else if nutrientID == 9 {
                        nutrientTotal += (Int(food.iron) * Int(intake.intakeAmount))
                    }
                }
            }
        }
        
        return nutrientTotal
    }
}

#Preview {
    CaloriesNutrientView()
}
