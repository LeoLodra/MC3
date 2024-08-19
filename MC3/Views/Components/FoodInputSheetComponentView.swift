//
//  FoodInputSheetComponentView.swift
//  MC3
//
//  Created by Jovanna Melissa on 18/08/24.
//

import SwiftUI

struct FoodInputSheetComponentView: View {
    var foodName:String
    var foodServingPortion:Int
    var foodCalorie:Int
    var foodProtein:Int
    var foodFolicAcid:Int
    var foodCalcium:Int
    @State private var foodPortion:Int = 0
    @State private var foodLogDate:Date = Date()
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundStyle(.lightgraybg)
                .opacity(0.3)
                .ignoresSafeArea()
            
            VStack(alignment: .leading){
                Text("Add Food")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding(.bottom, 20)
                    .padding(.top, 40)
                
                HStack(alignment: .bottom){
                    Text(foodName)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text("\(foodServingPortion)gr/portion")
                        .foregroundStyle(.darkgraytext)
                }
                
                
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.yellowprimary)
                        
                        VStack{
                            Text("\(foodCalorie)Kcal")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text("Calorie")
                        }
                    }
                    .frame(width: 100, height: 80)
                    
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.yellowprimary)
                        
                        HStack{
                            VStack{
                                Text("\(foodProtein)g")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                Text("Protein")
                            }
                            
                            Divider()
                            
                            VStack{
                                Text("\(foodFolicAcid)mg")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                Text("Folate")
                            }
                            
                            Divider()
                            
                            VStack{
                                Text("\(foodCalcium)mg")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                Text("Calcium")
                            }
                        }
                        .padding()
                    }
                    .frame(width: 250, height: 80)
                }
                .padding(.top, 20)
                
                HStack{
                    Text("Amount")
                        .font(.title3)
                    
                    Spacer()
                    
                    TextField(
                        "",
                        value: $foodPortion,
                        format: .number
                    )
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 150)
                    
                    Text("portion")
                }
                .padding(.top, 20)
                
                HStack{
                    Text("Input date")
                        .font(.title3)
                    
                    DatePicker("", selection: $foodLogDate, displayedComponents: [.date])
                }
                .padding(.top, 20)
                
                Button(action: {
                    
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 9999)
                            .foregroundStyle(.blueprimary)
                        HStack{
                            Image(systemName: "plus.circle.fill")
                            Text("Add Food")
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(height: 50)
                    .foregroundStyle(.white)
                    .padding()
                })
            }
            .padding()
            
            
        }
    }
}

#Preview {
    FoodInputSheetComponentView(foodName: "Rujak Cingur Vegetarian Khas Surabaya Barat Daya", foodServingPortion: 299, foodCalorie: 300, foodProtein: 1, foodFolicAcid: 39, foodCalcium: 39)
}
