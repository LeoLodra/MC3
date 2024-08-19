//
//  FoodCardViewComponent.swift
//  MC3
//
//  Created by Jovanna Melissa on 18/08/24.
//

import SwiftUI

struct FoodCardViewComponent: View {
    var foodName: String
    var foodStatus: String
    var foodCalorie: Int
    var foodServing: Int
    var foodProtein: Int
    var foodFolicAcid: Int
    var foodCalcium: Int
    @State private var foodStatusColor:Color = .greensuccess
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
                        Text(foodStatus)
                        Spacer()
                    }
                    .foregroundStyle(foodStatusColor)
                    
                    Text(foodName)
                        .fontWeight(.bold)
                        .font(.headline)
                    
                    Text("\(foodCalorie) kcal | \(foodServing)gr/serving")
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
            FoodInputSheetComponentView(foodName: foodName, foodServingPortion: foodServing, foodCalorie: foodCalorie, foodProtein: foodProtein, foodFolicAcid: foodFolicAcid, foodCalcium: foodCalcium)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
        .onAppear(perform: {
            determineStatusColor(foodStatus: foodStatus)
        })
    }
}

extension FoodCardViewComponent{
    func determineStatusColor(foodStatus: String){
        if foodStatus == "Safe"{
            foodStatusColor = .greensuccess
        } else if foodStatus == "Limited Consumption"{
            foodStatusColor = .orangewarning
        } else {
            foodStatusColor = .redwarning
        }
    }
}

#Preview {
    FoodCardViewComponent(foodName: "Rujak Cingur Vegetarian Khas Surabaya Barat Daya", foodStatus: "Safe", foodCalorie: 257, foodServing: 300, foodProtein: 39, foodFolicAcid: 39, foodCalcium: 39)
}
