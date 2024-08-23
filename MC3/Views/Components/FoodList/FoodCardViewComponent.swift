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
    @ObservedObject var vm:FoodLogViewModel
    
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
                            .font(.custom("Lato-Regular", size: 15))
                        Spacer()
                    }
                    .foregroundStyle(foodStatusColor)
                    
                    Text(food.title)
                        .font(.custom("Lato-Bold", size: 17))
                    
                    Text("\(food.calories) kcal | \(food.servingSize)gr/serving")
                        .font(.custom("Lato-Regular", size: 13))
                        .foregroundStyle(.darkgraytext)
                    
                    NavigationLink{
                        #warning("Panggil food detail page disini")
                    } label: {
                        HStack{
                            Text("See details")
                                .font(.custom("Lato-Regular", size: 17))
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
            FoodInputSheetComponentView(food: food, showingSheet: $showingSheet, vm: vm)
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
