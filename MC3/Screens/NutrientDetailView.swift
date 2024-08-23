//
//  NutrientDetailView.swift
//  MC3
//
//  Created by Jovanna Melissa on 15/08/24.
//

import SwiftUI
import Charts

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
    @State private var weeklyFoodCalories: [(Date, Int)] = []
    @State private var weeklyEatenFoods:[Food] = []
    @State private var currentDate:Date = Date()
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \User.createdAt, ascending: false)],
        animation: .default)
    var users: FetchedResults<User>
    
    
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
                                .disabled(viewDate == user?.lastHaidAt)
                                
                                Spacer()
                                
                                Text("\(viewDate.formatted(date: .complete, time: .omitted))")
                                    .font(.custom("Lato-Bold", size: 20))
                                
                                Spacer()
                                
                                Button(action: {
                                    var calendar = Calendar.current
                                    if let lastHaidAt = user?.lastHaidAt {
                                        let weekdayComponent = calendar.component(.weekday, from: lastHaidAt)
                                        calendar.firstWeekday = weekdayComponent
                                    }
                                    viewDate = calendar.date(byAdding: .day, value: 1, to: viewDate) ?? viewDate
                                    print("viewdate: \(viewDate)")
                                    
                                }, label: {
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(Calendar.current.isDate(viewDate, equalTo: Date(), toGranularity: .day) ? .gray : .black)
                                })
                                .disabled(Calendar.current.isDate(viewDate, equalTo: Date(), toGranularity: .day))
                            }
                        } else {
                            HStack{
                                Button(action: {
                                    if viewWeek > 1 {
                                        viewWeek -= 1
                                    }
                                }, label: {
                                    Image(systemName: "chevron.left")
                                        .foregroundStyle(viewWeek == 1 ? .gray : .black)
                                })
                                .disabled(viewWeek == 1)
                                
                                Spacer()
                                
                                Text("Week \(viewWeek), Trimester \(viewTrimester)")
                                    .font(.custom("Lato-Bold", size: 20))
                                
                                Spacer()
                                
                                Button(action: {
                                    viewWeek += 1
                                }, label: {
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(viewWeek == currentWeek ? .gray : .black)
                                })
                                .disabled(viewWeek == currentWeek)
                            }
                        }
                    }
                    .padding()
                }
                .frame(height: 90)
                
                Text("Intake Summary")
                    .font(.custom("Lato-Bold", size: 24))
                    .foregroundStyle(.darktext)
                    .padding(.top)
                
                Text("Calories")
                    .font(.custom("Lato-Bold", size: 20))
                    .foregroundStyle(.darkgraytext)
                    .padding(.top, 2)
                
                if period == 0{
                    HStack {
                        Spacer()
                        NutrientRingComponentView(nutrientName: "Calories", nutrientTarget: viewTrimester == 1 ? 2430 : 2550, nutrientIntake: Float(vm.getTotalCalories(foodLogDate: viewDate, foodIntakes: self.foodIntakes, eatenFoods: self.eatenFoods)), nutrientUnit: "Kcal")
                            .frame(width: 200, height: 200)
                        .padding(.top, 20)
                        Spacer()
                    }
                    
                    Text("Nutrients")
                        .font(.custom("Lato-Bold", size: 20))
                        .foregroundStyle(.darkgraytext)
                        .padding(.top, 20)
                        .padding(.bottom, 8)
                    
                    ForEach(nutrientTargets){target in
                        if(target.trimester != nil && target.trimester == viewTrimester || target.trimester == nil){
                            if target.id <= 5{
                                NutrientIntakeProgressComponentView(nutrientName: target.nutrientName, nutrientIntake: Float(vm.getTotalNutrients(nutrientID: target.id, foodIntakes: self.foodIntakes, foodEaten: self.eatenFoods)), nutrientTarget: target.nutrientTarget, nutrientUnit: target.nutrientUnit)
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
                                                .font(.custom("Lato-Regular", size: 13))
                                            Image(systemName: "chevron.down")
                                        }
                                        
                                    })
                                }
                            }
                            
                            if(seeMoreClicked && target.id >= 7){
                                NutrientIntakeProgressComponentView(nutrientName: target.nutrientName, nutrientIntake: Float(vm.getTotalNutrients(nutrientID: target.id, foodIntakes: self.foodIntakes, foodEaten: self.eatenFoods)), nutrientTarget: target.nutrientTarget, nutrientUnit: target.nutrientUnit)
                                    .padding(.bottom)
                            }
                        }
                    }
                    
                    Text("Food Eaten")
                        .font(.custom("Lato-Bold", size: 24))
                        .foregroundStyle(.darkgraytext)
                        .padding(.top, 20)
                        .padding(.bottom, 8)
                    
                    ForEach(foodIntakes) { intake in
                        FoodEatenCardComponentView(food: vm.getFood(foodIntake: intake, eaten: eatenFoods)!, intakeAmount: Int(intake.intakeAmount))
                            .padding(.bottom)
                    }
                } else {
                    Chart(weeklyFoodCalories, id: \.0) { date, calories in
                        BarMark(
                            x: .value("Date", date, unit: .day),
                            y: .value("Calories", calories)
                        )
                        .foregroundStyle(.blueprimary)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .annotation {
                            Text(verbatim: calories.formatted())
                                .font(.caption)
                        }
                    }
                    .chartXAxis {
                        AxisMarks(values: .stride(by: .day)) {
                            AxisValueLabel(format: .dateTime.day(.defaultDigits))
                        }
                    }
                    .chartYAxis{
                        AxisMarks(position: .leading)
                    }
                    .frame(height: 200)
                    
                    Text("Nutrients")
                        .font(.custom("Lato-Bold", size: 20))
                        .foregroundStyle(.darkgraytext)
                        .padding(.top, 20)
                        .padding(.bottom, 8)
                    
                    ForEach(nutrientTargets){target in
                        if(target.trimester != nil && target.trimester == viewTrimester || target.trimester == nil){
                            if target.id <= 5{
                                NutrientIntakeProgressComponentView(nutrientName: target.nutrientName, nutrientIntake: Float(vm.getTotalNutrients(nutrientID: target.id, foodIntakes: self.weeklyFoodIntakes, foodEaten: self.weeklyEatenFoods)), nutrientTarget: (target.nutrientTarget * 7), nutrientUnit: target.nutrientUnit)
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
                                                .font(.custom("Lato-Regular", size: 13))
                                            Image(systemName: "chevron.down")
                                        }
                                        
                                    })
                                }
                            }
                            
                            if(seeMoreClicked && target.id >= 7){
                                NutrientIntakeProgressComponentView(nutrientName: target.nutrientName, nutrientIntake: Float(vm.getTotalNutrients(nutrientID: target.id, foodIntakes: self.weeklyFoodIntakes, foodEaten: self.weeklyEatenFoods)), nutrientTarget: (target.nutrientTarget * 7), nutrientUnit: target.nutrientUnit)
                                    .padding(.bottom)
                            }
                        }
                    }
                    
                    Text("Food Eaten")
                        .font(.custom("Lato-Bold", size: 24))
                        .foregroundStyle(.darktext)
                        .padding(.top, 20)
                        .padding(.bottom, 8)
                    
                    ForEach(weeklyFoodIntakes) { intake in
                        Text("\(intake.intakeAt!.formatted(date: .abbreviated, time: .omitted))")
                        FoodEatenCardComponentView(food: vm.getFood(foodIntake: intake, eaten: weeklyEatenFoods)!, intakeAmount: Int(intake.intakeAmount))
                            .padding(.bottom)
                    }
                }
            }
            .padding()
        }
        .onAppear(perform: {
            viewWeek = currentWeek
            nutrientTargets = vm.populateNutrientTargetData()
            foodIntakes = vm.fetchFoodIntake(foodLogDate: viewDate, viewContext: viewContext)
            eatenFoods = vm.getEatenFood(foodIntakes: foodIntakes)
            
            weeklyFoodIntakes = vm.fetchWeeklyFoodIntake(userLastHaid: user?.lastHaidAt, viewContext: viewContext, week: viewWeek)
            weeklyEatenFoods = vm.getEatenFood(foodIntakes: weeklyFoodIntakes)
            weeklyFoodCalories = vm.getWeeklyCaloriesByDay(userLastHaid: user?.lastHaidAt, weeklyFoodIntakes: self.weeklyFoodIntakes, weeklyEatenFoods: self.weeklyEatenFoods, week: viewWeek)
        })
        .onChange(of: viewDate){
            seeMoreClicked = false
            
            nutrientTargets.removeAll()
            foodIntakes.removeAll()
            eatenFoods.removeAll()
            weeklyFoodIntakes.removeAll()
            
            nutrientTargets = vm.populateNutrientTargetData()
            foodIntakes = vm.fetchFoodIntake(foodLogDate: viewDate, viewContext: viewContext)
            eatenFoods = vm.getEatenFood(foodIntakes: foodIntakes)
        }
        .onChange(of: viewWeek){
            nutrientTargets.removeAll()
            weeklyFoodIntakes.removeAll()
            weeklyEatenFoods.removeAll()
            
            nutrientTargets = vm.populateNutrientTargetData()
            weeklyFoodIntakes = vm.fetchWeeklyFoodIntake(userLastHaid: user?.lastHaidAt, viewContext: viewContext, week: viewWeek)
            weeklyEatenFoods = vm.getEatenFood(foodIntakes: weeklyFoodIntakes)
            weeklyFoodCalories = vm.getWeeklyCaloriesByDay(userLastHaid: user?.lastHaidAt, weeklyFoodIntakes: self.weeklyFoodIntakes, weeklyEatenFoods: self.weeklyEatenFoods, week: viewWeek)
        }
    }
}

extension NutrientDetailView{
    private var user: User? {
        users.first
    }
    
    private var currentWeek: Int {
        let calendar = Calendar.current
        let currentDate = Date()
        let weekNumber = calendar.dateComponents([.weekOfYear], from: user?.lastHaidAt ?? currentDate, to: currentDate).weekOfYear ?? 0
        
        return weekNumber
    }
    
    private var startOfTheWeek:Date {
        
        var calendar = Calendar.current
        if let lastHaidAt = user?.lastHaidAt {
            let weekdayComponent = calendar.component(.weekday, from: lastHaidAt)
            calendar.firstWeekday = weekdayComponent
        }
        let currentStartofWeek = calendar.date(byAdding: .weekOfYear, value: viewWeek, to: user?.lastHaidAt ?? Date()) ?? Date()
            
        return currentStartofWeek
    }
}

//#Preview {
//    NutrientDetailView()
//}
