//
//  FoodInfoScreenView.swift
//  MC3
//
//  Created by Leonardo Marhan on 21/08/24.
//

import SwiftUI

struct FoodInfoScreenView: View {
    var food:Food
    @State private var foodPortion:Int = 1
    @State private var foodStatusColor:Color = .greensuccess
    @State private var foodStatusString:String = ""    
    var body: some View {
        VStack {
            HStack (alignment: .top) {
                Text("\(food.title)")
                    .font(.custom("Lato-Bold", size: 32))
                Spacer()
                VStack {
                    HStack {
                        Circle()
                            .frame(width: 8)
                        Text(foodStatusString)
                            .font(.custom("Lato-Regular", size: 15))
                    }
                }
                .foregroundColor(foodStatusColor)
            }
            HStack {
                Text("\(food.servingSize)gr/serving")
                    .font(.custom("Lato-Light", size: 15))
                Spacer()
            }
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.yellowprimary)
                    
                    VStack{
                        Text("\(food.calories * foodPortion)Kcal")
                            .font(.custom("Lato-Bold", size: 17))
                        Text("Calorie")
                            .font(.custom("Lato-Regular", size: 17))
                    }
                }
                .frame(width: 100, height: 80)
                
                
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.yellowprimary)
                    
                    HStack{
                        VStack{
                            Text("\(food.protein * Float(foodPortion), specifier: "%.2f")g")
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.custom("Lato-Bold", size: 15))
                            Text("Protein")
                                .font(.custom("Lato-Regular", size: 15))
                        }
                        
                        Divider()
                        
                        VStack{
                            Text("\(food.folate * Float(foodPortion), specifier: "%.2f")mg")
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.custom("Lato-Bold", size: 15))
                            Text("Folate")
                                .font(.custom("Lato-Regular", size: 15))
                        }
                        
                        Divider()
                        
                        VStack{
                            Text("\(food.calcium * Float(foodPortion), specifier: "%.2f")mg")
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.custom("Lato-Bold", size: 15))
                            Text("Calcium")
                                .font(.custom("Lato-Regular", size: 15))
                        }
                    }
                    .padding()
                }
                .frame(width: 250, height: 80)
            }
            HStack {
                Text("NUTRIONAL INFO")
                    .font(.custom("Lato-Bold", size: 16))
                Spacer()
                Text("/serving")
                    .font(.custom("Lato-Light", size: 12))
            }
            .padding(.vertical)
            VStack {
                NutrientInfoComponentView(nutrientName: "Vitamin A", nutrientAmount: food.vitaminA)
                NutrientInfoComponentView(nutrientName: "Vitamin D", nutrientAmount: food.vitaminD)
                NutrientInfoComponentView(nutrientName: "Zinc", nutrientAmount: food.fiber)
                NutrientInfoComponentView(nutrientName: "Iron", nutrientAmount: food.iron)
            }
            Spacer()
        }
        .padding()
        .onAppear(perform: {
            determineStatusColor(foodStatus: food.edibleStatus.rawValue)
        })
    }
}

extension FoodInfoScreenView {
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


