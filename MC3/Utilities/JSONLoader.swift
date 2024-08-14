//
//  JSONLoader.swift
//  MC3
//
//  Created by mg0 on 14/08/24.
//

import Foundation

class JSONLoader {
    static func loadFoods() -> [Food] {
        guard let url = Bundle.main.url(forResource: "Foods", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Error loading Foods.json")
            return []
        }
        
        do {
            let foods = try JSONDecoder().decode([Food].self, from: data)
            return foods
        } catch {
            print("Error decoding Foods.json: \(error)")
            return []
        }
    }
    
    static func loadFoodTags() -> [FoodTag] {
        guard let url = Bundle.main.url(forResource: "FoodTags", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Error loading FoodTags.json")
            return []
        }
        
        do {
            let foodTags = try JSONDecoder().decode([FoodTag].self, from: data)
            return foodTags
        } catch {
            print("Error decoding FoodTags.json: \(error)")
            return []
        }
    }
}
