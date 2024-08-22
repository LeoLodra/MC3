//
//  FoodInputSheetComponentView.swift
//  MC3
//
//  Created by Jovanna Melissa on 18/08/24.
//

import SwiftUI

struct FoodInputSheetComponentView: View {
    
    var food:Food
    @State private var foodPortion:Int = 1
    @State private var foodLogDate:Date = Date()
    @Binding var showingSheet:Bool
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var vm:FoodLogViewModel
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundStyle(.lightgraybg)
                .opacity(0.3)
                .ignoresSafeArea()
            
            VStack(alignment: .leading){
                Text("Add Food")
                    .font(.custom("Lato-Bold", size: 20))
                    .padding(.bottom, 20)
                    .padding(.top, 40)
                
                HStack(alignment: .bottom){
                    Text(food.title)
                        .font(.custom("Lato-Bold", size: 24))
                    
                    Spacer()
                    
                    Text("\(food.servingSize)gr/portion")
                        .font(.custom("Lato-Regular", size: 15))
                        .foregroundStyle(.darkgraytext)
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
                .padding(.top, 20)
                
                HStack{
                    Text("Amount")
                        .font(.custom("Lato-Regular", size: 17))
                    
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
                        .font(.custom("Lato-Regular", size: 17))
                }
                .padding(.top, 20)
                
                Button(action: {
                    let tf = foodIntakePortion(id: UUID().uuidString, food: food, portion: foodPortion)
                    vm.tempFoodLog.append(tf)
                    print(vm.tempFoodLog)
                    showingSheet = false
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 9999)
                            .foregroundStyle(.blueprimary)
                        HStack{
                            Image(systemName: "plus.circle.fill")
                            Text("Add Food")
                                .font(.custom("Lato-Bold", size: 17))
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

//#Preview {
//    FoodInputSheetComponentView()
//}
