//
//  NutrientDetailView.swift
//  MC3
//
//  Created by Jovanna Melissa on 15/08/24.
//

import SwiftUI

struct NutrientDetailView: View {
    @State private var period = 0
    @State private var viewDate = Date()
    @State private var viewWeek = 1
    @State private var viewTrimester = 1
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text("Let's see how far you've got!")
                .fontWeight(.bold)
                .font(.custom("Lato-Bold", size: 24))
                
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.yellowbg)
                    
                    VStack{
                        Picker("", selection: $period) {
                            Text("Daily").tag(0)
                            Text("Weekly").tag(1)
                        }
                        .pickerStyle(.segmented)
                        
                        Spacer()
                        
                        if period == 0{
                            HStack{
                                Button(action: {
                                    
                                }, label: {
                                    Image(systemName: "chevron.left")
                                        .foregroundStyle(.black)
                                })
                                
                                Spacer()
                                
                                Text("\(viewDate.formatted(date: .complete, time: .omitted))")
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                }, label: {
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.black)
                                })
                            }
                        } else {
                            HStack{
                                Button(action: {
                                    
                                }, label: {
                                    Image(systemName: "chevron.left")
                                        .foregroundStyle(.black)
                                })
                                
                                Spacer()
                                
                                Text("Week \(viewWeek), Trimester \(viewTrimester)")
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                }, label: {
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.black)
                                })
                            }
                        }
                        
                    }
                    .padding()
                }
                .frame(height: 90)
                
                if period == 0{
                    Text("Nutrition Summary")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    HStack {
                        Spacer()
                        NutrientRingComponentView(nutrientName: "Calories", nutrientTarget: 2257, nutrientIntake: 250, nutrientUnit: "Kcal")
                            .frame(width: 200, height: 200)
                        .padding(.top, 20)
                        Spacer()
                    }
                } else {
                    Text("Hello this is weekly")
                }
                
                Text("Other Nutrients")
                    .fontWeight(.bold)
                    .foregroundStyle(.darkgraytext)
                    .font(.title3)
                    .padding([.top, .bottom], 20)
                
                
                HStack{
                    NutrientIntakeProgressComponentView(nutrientName: "Protein", nutrientIntake: 100, nutrientTarget: 200, nutrientUnit: "g")
                        .frame(width: 180)
                    
                    Spacer()
                    
                    NutrientIntakeProgressComponentView(nutrientName: "Protein", nutrientIntake: 100, nutrientTarget: 200, nutrientUnit: "g")
                        .frame(width: 180)
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    NutrientDetailView()
}
