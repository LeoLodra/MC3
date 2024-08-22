//
//  FoodEatenCardComponentView.swift
//  MC3
//
//  Created by Jovanna Melissa on 21/08/24.
//

import SwiftUI

struct FoodEatenCardComponentView: View {
    var food:Food
    var intakeAmount:Int
    @State private var foodStatusColor:Color = .greensuccess
    @State private var foodStatusString:String = ""
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 24)
                .foregroundStyle(.verylightgraybg)
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "circle.fill")
                            .font(.caption)
                        Text(foodStatusString)
                        
                        Spacer()
                        
                        Text("\(food.calories * intakeAmount) Kcal")
                            .fontWeight(.bold)
                            .foregroundStyle(.darkblueprimary)
                    }
                    .foregroundStyle(foodStatusColor)
                    
                    HStack{
                        Text(food.title)
                            .fontWeight(.bold)
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("\(intakeAmount) serving")
                            .foregroundStyle(.darkgraytext)
                    }
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.yellowbg)
                        
                        HStack{
                            Text("**\(food.protein * Float(intakeAmount), specifier: "%.0f")g** Protein")
                            Divider()
                            
                            Text("**\(food.folate * Float(intakeAmount), specifier: "%.0f")mg** Folic Acid")
                            Divider()
                            
                            Text("**\(food.calcium * Float(intakeAmount), specifier: "%.0f")mg** Calcium")
                        }
                        .foregroundStyle(.darkorangewarning)
                        .padding(.horizontal)
                        .font(.system(size: 13))
                    }
                    .frame(height: 30)
                    
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
            }
            .padding()
        }
        .frame(minHeight: 150, maxHeight: 200)
        .onAppear(perform: {
            determineStatusColor(foodStatus: food.edibleStatus.rawValue)
        })
    }
}

extension FoodEatenCardComponentView{
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
//    FoodEatenCardComponentView()
//}
