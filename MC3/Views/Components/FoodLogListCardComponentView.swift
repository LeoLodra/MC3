//
//  FoodLogListCardComponentView.swift
//  MC3
//
//  Created by Jovanna Melissa on 21/08/24.
//

import SwiftUI

struct FoodLogListCardComponentView: View {
    @State private var foodStatusColor:Color = .greensuccess
    @State private var foodStatusString:String = ""
    var food:foodIntakePortion
    @ObservedObject var vm:FoodLogViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 24)
                .foregroundStyle(.bluebg)
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "circle.fill")
                            .font(.caption)
                        Text(foodStatusString)
                        Spacer()
                    }
                    .foregroundStyle(foodStatusColor)
                    
                    Text(food.food.title)
                        .fontWeight(.bold)
                        .font(.headline)
                    
                    Text("\(food.food.calories * food.portion) kcal | \(food.portion) serving")
                        .font(.subheadline)
                        .foregroundStyle(.darkgraytext)
                }
                
                Button(action: {
                    if let index = vm.tempFoodLog.firstIndex(where: { $0.id == food.id }) {
                        vm.tempFoodLog.remove(at: index)
                    }
                }, label: {
                    Image(systemName: "x.circle")
                        .foregroundStyle(.blueprimary)
                        .font(.largeTitle)
                })
            }
            .padding()
        }
        .padding()
        .frame(minHeight: 100, maxHeight: 150)
        .onAppear(perform: {
            determineStatusColor(foodStatus: food.food.edibleStatus.rawValue)
        })
    }
}

extension FoodLogListCardComponentView{
    func determineStatusColor(foodStatus: String){
        if food.food.edibleStatus.rawValue == "safe"{
            foodStatusColor = .greensuccess
            foodStatusString = "Safe"
        } else if food.food.edibleStatus.rawValue == "caution"{
            foodStatusColor = .orangewarning
            foodStatusString = "Limited Consumption"
        } else {
            foodStatusColor = .redwarning
            foodStatusString = "Prohibited"
        }
    }
    
    
}

//#Preview {
//    FoodLogListCardComponentView()
//}
