//
//  NutrientDetailView.swift
//  MC3
//
//  Created by Jovanna Melissa on 15/08/24.
//

import SwiftUI

struct NutrientDetailView: View {
    @State private var period = 0
    @State private var viewDate = Date()
    @State private var viewWeek = 1
    @State private var viewTrimester = 1
    @State private var vm = NutrientTargetViewModel()
    @State private var nutrientTargets:[NutrientDailyTarget] = []
    @State private var seeMoreClicked = false
    @Environment(\.managedObjectContext) private var viewContext
    @State private var foodIntakes:[FoodIntake] = []
    @State private var eatenFoods:[Food] = []
    @State private var weeklyFoodIntakes:[FoodIntake] = []
    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text("Let's see how far you've got!")
                .fontWeight(.bold)
                .font(.custom("Lato-Bold", size: 24))
                
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.yellowbg)
                    
                    VStack{
                        Picker("", selection: $period) {
                            Text("Daily").tag(0)
                            Text("Weekly").tag(1)
                        }
                        .pickerStyle(.segmented)
                        
                        Spacer()
                        
                        if period == 0{
                            HStack{
                                Button(action: {
                                    viewDate = Calendar.current.date(byAdding: .day, value: -1, to: viewDate) ?? viewDate
                                    
                                }, label: {
                                    Image(systemName: "chevron.left")
                                        .foregroundStyle(.black)
                                })
                                
                                Spacer()
                                
                                Text("\(viewDate.formatted(date: .complete, time: .omitted))")
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Button(action: {
                                    viewDate = Calendar.current.date(byAdding: .day, value: 1, to: viewDate) ?? viewDate
                                    
                                }, label: {
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(Calendar.current.isDate(viewDate, equalTo: Date(), toGranularity: .day) ? .gray : .black)
                                })
                                .disabled(Calendar.current.isDate(viewDate, equalTo: Date(), toGranularity: .day))
                            }
                        } else {
                            HStack{
                                Button(action: {
                                    
                                }, label: {
                                    Image(systemName: "chevron.left")
                                        .foregroundStyle(.black)
                                })
                                
                                Spacer()
                                
                                Text("Week \(viewWeek), Trimester \(viewTrimester)")
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                }, label: {
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.black)
                                })
                            }
                        }
                        
                    }
                    .padding()
                }
                .frame(height: 90)
                
                Text("Intake Summary")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Text("Calories")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.darkgraytext)
                    .padding(.top, 2)
                
                if period == 0{
                    HStack {
                        Spacer()
                        NutrientRingComponentView(nutrientName: "Calories", nutrientTarget: viewTrimester == 1 ? 2430 : 2550, nutrientIntake: Float(getTotalCalories(foodLogDate: viewDate)), nutrientUnit: "Kcal")
                            .frame(width: 200, height: 200)
                        .padding(.top, 20)
                        Spacer()
                    }
                } else {
                    #warning("bikin chart untuk weekly total calories")
//                    Chart {
//                        ForEach(stats, id: \.city) { stat in
//                            BarMark(
//                                x: .value("City", stat.city),
//                                y: .value("Population", stat.population)
//                            )
//                            .opacity(0.3)
//                            .foregroundStyle(.red)
//                        }
//                    }
                }
                
                Text("Nutrients")
                    .fontWeight(.bold)
                    .foregroundStyle(.darkgraytext)
                    .font(.title3)
                    .padding(.top, 20)
                    .padding(.bottom, 8)
                
                ForEach(nutrientTargets){target in
                    if(target.trimester != nil && target.trimester == viewTrimester || target.trimester == nil){
                        if target.id <= 5{
                            NutrientIntakeProgressComponentView(nutrientName: target.nutrientName, nutrientIntake: Float(getTotalNutrients(nutrientID: target.id)), nutrientTarget: target.nutrientTarget, nutrientUnit: target.nutrientUnit)
                                .padding(.bottom)
                        }
                        
                        if (target.nutrientName == "Calcium" && seeMoreClicked == false){
                            HStack{
                                Spacer()
                                Button(action: {
                                    seeMoreClicked = true
                                }, label: {
                                    HStack{
                                        Text("See more")
                                        Image(systemName: "chevron.down")
                                    }
                                    
                                })
                            }
                        }
                        
                        if(seeMoreClicked && target.id >= 7){
                            NutrientIntakeProgressComponentView(nutrientName: target.nutrientName, nutrientIntake: Float(getTotalNutrients(nutrientID: target.id)), nutrientTarget: target.nutrientTarget, nutrientUnit: target.nutrientUnit)
                                .padding(.bottom)
                        }
                    }
                }
                
                Text("Food Eaten")
                    .fontWeight(.bold)
                    .foregroundStyle(.darkgraytext)
                    .font(.title3)
                    .padding(.top, 20)
                    .padding(.bottom, 8)
                
                ForEach(eatenFoods) { food in
                    FoodEatenCardComponentView(food: food, intakeAmount: getFoodIntake(foodID: food.id))
                        .padding(.bottom)
                }
            }
            .padding()
        }
        .onAppear(perform: {
            nutrientTargets = vm.populateNutrientTargetData()
            foodIntakes = vm.fetchFoodIntake(foodLogDate: viewDate, viewContext: viewContext)
            eatenFoods = vm.getEatenFood(foodIntakes: foodIntakes)
            print(eatenFoods)
            
            weeklyFoodIntakes = vm.fetchWeeklyFoodIntake(logStartDate: viewDate, viewContext: viewContext)
        })
        .onChange(of: viewDate){
            nutrientTargets.removeAll()
            foodIntakes.removeAll()
            eatenFoods.removeAll()
            weeklyFoodIntakes.removeAll()
            
            nutrientTargets = vm.populateNutrientTargetData()
            foodIntakes = vm.fetchFoodIntake(foodLogDate: viewDate, viewContext: viewContext)
            eatenFoods = vm.getEatenFood(foodIntakes: foodIntakes)
            weeklyFoodIntakes = vm.fetchWeeklyFoodIntake(logStartDate: viewDate, viewContext: viewContext)
        }
    }
    
    private func getFoodIntake(foodID: Int) -> Int{
        var foodIntake = 0
        
        for intake in foodIntakes{
            if intake.foodId == foodID{
                foodIntake = Int(intake.intakeAmount)
            }
        }
        
        return foodIntake
    }
    
    private func getTotalCalories(foodLogDate:Date) -> Int{
        var calorieTotal = 0
        
        for intake in foodIntakes{
            for food in eatenFoods{
                if intake.foodId == food.id{
                    calorieTotal += (food.calories * Int(intake.intakeAmount))
                }
            }
        }
        
        return calorieTotal
    }
    
    private func getTotalNutrients(nutrientID:Int) -> Int{
        var nutrientTotal = 0
        
        for intake in foodIntakes {
            for food in eatenFoods{
                if intake.foodId == food.id{
                    if nutrientID == 1 || nutrientID == 2 || nutrientID == 3{
                        nutrientTotal += (Int(food.protein) * Int(intake.intakeAmount))
                    } else if nutrientID == 4{
                        nutrientTotal += (Int(food.folate) * Int(intake.intakeAmount))
                    } else if nutrientID == 5{
                        nutrientTotal += (Int(food.calcium) * Int(intake.intakeAmount))
                    } else if nutrientID == 7{
                        nutrientTotal += (Int(food.vitaminA) * Int(intake.intakeAmount))
                    } else if nutrientID == 8{
                        nutrientTotal += (Int(food.vitaminD) * Int(intake.intakeAmount))
                    } else if nutrientID == 9{
                        nutrientTotal += (Int(food.iron) * Int(intake.intakeAmount))
                    }
                }
            }
        }
        
        return nutrientTotal
    }
}

//#Preview {
//    NutrientDetailView()
//}
