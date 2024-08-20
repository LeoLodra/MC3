//
//  FoodCardViewComponent.swift
//  MC3
//
//  Created by Jovanna Melissa on 18/08/24.
//

import SwiftUI

struct FoodCardViewComponent: View {
    var food:Food
    @State private var foodStatusColor:Color = .greensuccess
    @State private var foodStatusString:String = ""
    @State var showingSheet = false
    
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
                    
                    Text(food.title)
                        .fontWeight(.bold)
                        .font(.headline)
                    
                    Text("\(food.calories) kcal | \(food.servingSize)gr/serving")
                        .font(.subheadline)
                        .foregroundStyle(.darkgraytext)
                    
                    NavigationLink{
                        
                    } label: {
                        HStack{
                            Text("See details")
                                .foregroundStyle(.darkblueprimary)
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.darkblueprimary)
                        }
                        
                    }
                    .padding(.top, 10)
                }
                
                Button(action: {
                    showingSheet = true
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundStyle(.blueprimary)
                        .font(.largeTitle)
                })
            }
            .padding()
            
        }
        .padding()
        .frame(minHeight: 150, maxHeight: 200)
        .sheet(isPresented: $showingSheet){
            FoodInputSheetComponentView(food: food, showingSheet: $showingSheet)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
        .onAppear(perform: {
            determineStatusColor(foodStatus: food.edibleStatus.rawValue)
        })
    }
}

extension FoodCardViewComponent{
    func determineStatusColor(foodStatus: String){
        if food.edibleStatus.rawValue == "safe"{
            foodStatusColor = .greensuccess
            foodStatusString = "Safe"
        } else if food.edibleStatus.rawValue == "caution"{
            foodStatusColor = .orangewarning
            foodStatusString = "Limited Consumption"
        } else {
            foodStatusColor = .redwarning
            foodStatusString = "Prohibited"
        }
    }
}

//#Preview {
//    FoodCardViewComponent(foodName: "Rujak Cingur Vegetarian Khas Surabaya Barat Daya", foodStatus: "safe", foodCalorie: 257, foodServing: 300, foodProtein: 39, foodFolicAcid: 39, foodCalcium: 39)
//}
