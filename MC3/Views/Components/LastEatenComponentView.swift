//
//  LastEatenComponentView.swift
//  MC3
//
//  Created by Leonardo Marhan on 22/08/24.
//

import SwiftUI

struct LastEatenComponentView: View {
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
                    HStack (alignment: .top){
                        Text(food.title)
                            .font(.custom("Lato-Bold", size: 15))
                        
                        Spacer()
                        VStack {
                            Text("\(food.calories * intakeAmount) Kcal")
                                .font(.custom("Lato-Bold", size: 15))
                            
                            Text("\(intakeAmount) serving")
                                .font(.custom("Lato-Regular", size: 13))
                                .foregroundStyle(.darkgraytext)
                        }
                    }
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.white)
                        
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
                }
            }
            .padding()
        }
        .frame(height: 90)
    }
}

#Preview {
    GoalsScreenView()
}

