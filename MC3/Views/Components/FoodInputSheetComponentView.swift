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
                    Text(food.title)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text("\(food.servingSize)gr/portion")
                        .foregroundStyle(.darkgraytext)
                }
                
                
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.yellowprimary)
                        
                        VStack{
                            Text("\(food.calories * foodPortion)Kcal")
                                .font(.headline)
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
                                Text("\(food.protein * Float(foodPortion), specifier: "%.2f")g")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text("Protein")
                            }
                            
                            Divider()
                            
                            VStack{
                                Text("\(food.folate * Float(foodPortion), specifier: "%.2f")mg")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text("Folate")
                            }
                            
                            Divider()
                            
                            VStack{
                                Text("\(food.calcium * Float(foodPortion), specifier: "%.2f")mg")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .font(.subheadline)
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
                    logFoodIntake(food: food)
                    showingSheet = false
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
    
    private func logFoodIntake(food: Food) {
        let newFoodIntake = FoodIntake(context: viewContext)
        newFoodIntake.intakeAt = foodLogDate
        newFoodIntake.foodId = Int64(food.id)
        newFoodIntake.intakeAmount = Int64(foodPortion)
        newFoodIntake.id = UUID()
        
        do {
            try viewContext.save()
            print("Food intake logged successfully")
        } catch {
            // Handle the error, e.g., show an alert
            print("Failed to save food intake: \(error.localizedDescription)")
        }
    }
}

//#Preview {
//    FoodInputSheetComponentView()
//}
