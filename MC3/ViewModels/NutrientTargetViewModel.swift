//
//  NutrientDailyTarget.swift
//  MC3
//
//  Created by Jovanna Melissa on 21/08/24.
//

import Foundation
import CoreData

struct NutrientDailyTarget:Identifiable{
    var id: Int
    var trimester: Int?
    var nutrientName: String
    var nutrientTarget: Float
    var nutrientUnit: String
}

class NutrientTargetViewModel:ObservableObject{
    private var nutrientDailyTargets:[NutrientDailyTarget] = []
    
    func populateNutrientTargetData() -> [NutrientDailyTarget]{
        nutrientDailyTargets.removeAll()
        
        let protein1 = NutrientDailyTarget(id: 1, trimester: 1, nutrientName: "Protein", nutrientTarget: 56, nutrientUnit: "gr")
        nutrientDailyTargets.append(protein1)
        
        let protein2 = NutrientDailyTarget(id: 2, trimester: 2, nutrientName: "Protein", nutrientTarget: 65, nutrientUnit: "gr")
        nutrientDailyTargets.append(protein2)
        
        let protein3 = NutrientDailyTarget(id: 3, trimester: 3, nutrientName: "Protein", nutrientTarget: 85, nutrientUnit: "gr")
        nutrientDailyTargets.append(protein3)
        
        let folicacid = NutrientDailyTarget(id: 4, nutrientName: "Folic Acid", nutrientTarget: 600, nutrientUnit: "mcg")
        nutrientDailyTargets.append(folicacid)
        
        let calcium = NutrientDailyTarget(id: 5, nutrientName: "Calcium", nutrientTarget: 1000, nutrientUnit: "mg")
        nutrientDailyTargets.append(calcium)
        
        let zinc = NutrientDailyTarget(id: 6, nutrientName: "Zinc", nutrientTarget: 11, nutrientUnit: "mg")
        nutrientDailyTargets.append(zinc)
        
        let vita = NutrientDailyTarget(id: 7, nutrientName: "Vit A", nutrientTarget: 770, nutrientUnit: "mcg")
        nutrientDailyTargets.append(vita)
        
        let vitd = NutrientDailyTarget(id: 8, nutrientName: "Vit D", nutrientTarget: 15, nutrientUnit: "mg")
        nutrientDailyTargets.append(vitd)
        
        let iron = NutrientDailyTarget(id: 9, nutrientName: "Iron", nutrientTarget: 27, nutrientUnit: "mg")
        nutrientDailyTargets.append(iron)
        
        return nutrientDailyTargets
    }
    
    
    func fetchFoodIntake(foodLogDate: Date, viewContext: NSManagedObjectContext) -> [FoodIntake] {
        var dailyFoodIntake:[FoodIntake] = []
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: foodLogDate)
        
        var components = DateComponents()
        components.day = 1
        let endOfDay = calendar.date(byAdding: components, to: startOfDay)!
        
        let fetchRequest = FoodIntake.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "intakeAt >= %@ AND intakeAt < %@", startOfDay as NSDate, endOfDay as NSDate)
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            
            if !results.isEmpty {
                for foodIntake in results {
                    dailyFoodIntake.append(foodIntake)
                }
            }
        } catch {
            print("Failed to fetch food intake: \(error.localizedDescription)")
        }
        
        return dailyFoodIntake
    }
    
    func getEatenFood(foodIntakes:[FoodIntake]) -> [Food]{
        var eatenFoods:[Food] = []
        let foods = JSONLoader.loadFoods()
        
        for intake in foodIntakes{
            for food in foods{
                if intake.foodId == food.id{
                    eatenFoods.append(food)
                }
            }
        }
        
        return eatenFoods
    }
    
    func fetchWeeklyFoodIntake(foodLogDate:Date, viewContext:NSManagedObjectContext) -> [FoodIntake]{
        let calendar = Calendar.current
        
        guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: foodLogDate)?.start else {
            return []
        }
        
        var weeklyFoodIntake:[FoodIntake] = []
        
        var components = DateComponents()
        components.day = 6
        let endOfWeek = calendar.date(byAdding: components, to: startOfWeek)!
        
        let fetchRequest = FoodIntake.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "intakeAt >= %@ AND intakeAt < %@", startOfWeek as NSDate, endOfWeek as NSDate)
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            
            if !results.isEmpty {
                for foodIntake in results {
                    weeklyFoodIntake.append(foodIntake)
                }
            }
        } catch {
            print("Failed to fetch food intake: \(error.localizedDescription)")
        }
        
        return weeklyFoodIntake
    }
    
    func getFood(foodIntake:FoodIntake, eaten:[Food]) -> Food?{
        
        for food in eaten{
            if food.id == foodIntake.foodId{
                return food
            }
        }
        
        return nil
    }
    
    func getTotalCalories(foodLogDate:Date, foodIntakes:[FoodIntake], eatenFoods:[Food]) -> Int{
        var calorieTotal = 0
        
        for intake in foodIntakes{
            for food in eatenFoods{
                if intake.foodId == food.id{
                    calorieTotal += (food.calories * Int(intake.intakeAmount))
                    break
                }
            }
        }
        
        return calorieTotal
    }
    
    func getWeeklyCaloriesByDay(foodLogDate: Date, weeklyFoodIntakes:[FoodIntake], weeklyEatenFoods:[Food]) -> [(Date, Int)] {
        let calendar = Calendar.current
        
        guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: foodLogDate)?.start else {
            return []
        }
        
        var dailyCalories: [Date: Int] = [:]
        
        for dayOffset in 0..<7 {
            if let currentDate = calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek) {
                dailyCalories[currentDate] = 0
                
                for intake in weeklyFoodIntakes {
                    if let intakeDate = intake.intakeAt, calendar.isDate(intakeDate, inSameDayAs: currentDate) {
                        for food in weeklyEatenFoods {
                            if intake.foodId == food.id {
                                dailyCalories[currentDate]! += (food.calories * Int(intake.intakeAmount))
                                break
                            }
                        }
                    }
                }
            }
        }
        return dailyCalories.sorted(by: { $0.key < $1.key })
    }
    
    func getTotalNutrients(nutrientID:Int, foodIntakes:[FoodIntake], foodEaten:[Food]) -> Int{
        var nutrientTotal = 0
        
        for intake in foodIntakes {
            for food in foodEaten{
                if intake.foodId == food.id{
                    if nutrientID == 1 || nutrientID == 2 || nutrientID == 3{
                        nutrientTotal += (Int(food.protein) * Int(intake.intakeAmount))
                        break
                    } else if nutrientID == 4{
                        nutrientTotal += (Int(food.folate) * Int(intake.intakeAmount))
                        break
                    } else if nutrientID == 5{
                        nutrientTotal += (Int(food.calcium) * Int(intake.intakeAmount))
                        break
                    } else if nutrientID == 7{
                        nutrientTotal += (Int(food.vitaminA) * Int(intake.intakeAmount))
                        break
                    } else if nutrientID == 8{
                        nutrientTotal += (Int(food.vitaminD) * Int(intake.intakeAmount))
                        break
                    } else if nutrientID == 9{
                        nutrientTotal += (Int(food.iron) * Int(intake.intakeAmount))
                        break
                    }
                }
            }
        }
        
        return nutrientTotal
    }
}
