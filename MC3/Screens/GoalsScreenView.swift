//
//  GoalsScreenView.swift
//  MC3
//
//  Created by Leonardo Marhan on 13/08/24.
//

import SwiftUI

struct GoalsScreenView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \User.createdAt, ascending: false)],
        animation: .default)
    var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            VStack {
                VStack (alignment: .leading){
                    HStack {
                        Text("Hi ")
                            .font(.custom("Lato-Regular", size: 24))
                        +
                        Text("\(users.first?.fullName ?? "Mother")!")
                            .font(.custom("Lato-Bold", size: 24))
                        Spacer()
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 29))
                    }
                    Text("You're in ")
                        .font(.custom("Lato-Regular", size: 24))
                    +
                    Text("Week 3")
                        .font(.custom("Lato-Bold", size: 24))
                    
                    NavigationLink(destination: NutrientDetailView()) {
                        CaloriesNutrientView()
                    }
                    .foregroundColor(.black)
                    
                    Spacer()
                    
                    NavigationLink(destination: WeightScreenView()) {
                        WeightView()
                    }
                    .foregroundColor(.black)
                }
            }
            .padding()
            .background(
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    GoalsScreenView()
}
