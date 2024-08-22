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
        
        let calcium = NutrientDailyTarget(id: 5, nutrientName: "Calcium", nutrientTarget: 1, nutrientUnit: "gr")
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
                    print("masuk food intake")
                    print(foodIntake.intakeAmount)
                    print("tanggal skrg: \(Date())")
                    print("tanggal: \(foodIntake.intakeAt ?? Date())")
                    
                    dailyFoodIntake.append(foodIntake)
                }
            } else {
                print("bolonggg")
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
    
    func fetchWeeklyFoodIntake(logStartDate:Date, viewContext:NSManagedObjectContext) -> [FoodIntake]{
        var weeklyFoodIntake:[FoodIntake] = []
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: logStartDate)
        
        var components = DateComponents()
        components.day = 7
        let endOfDay = calendar.date(byAdding: components, to: startOfDay)!
        
        let fetchRequest = FoodIntake.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "intakeAt >= %@ AND intakeAt < %@", startOfDay as NSDate, endOfDay as NSDate)
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            
            if !results.isEmpty {
                for foodIntake in results {
                    weeklyFoodIntake.append(foodIntake)
                }
            } else {
                print("bolonggg")
            }
        } catch {
            print("Failed to fetch food intake: \(error.localizedDescription)")
        }
        
        return weeklyFoodIntake
    }
}
