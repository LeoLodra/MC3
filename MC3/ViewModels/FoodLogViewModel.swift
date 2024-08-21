//
//  FoodLogViewModel.swift
//  MC3
//
//  Created by Jovanna Melissa on 21/08/24.
//

import Foundation

struct foodIntakePortion:Identifiable{
    var id: String
    
    var food:Food
    var portion:Int
}

class FoodLogViewModel: ObservableObject, Identifiable{
    @Published var tempFoodLog:[foodIntakePortion] = []
//    @Published var foodPortion:[Int] = []
}
