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
    
    @State private var isExpanded = false
    
    var body: some View {
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
                Text("You are in your 1st Trimester")
                    .font(.custom("Lato-Regular", size: 13))
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Today's Goals")
                            .font(.custom("Lato-Bold", size: 24))
                        Spacer()
                        Image(systemName: "chevron.forward")
                            .font(.system(size: 24))
                            .foregroundColor(.blueprimary)
                    }
                    HStack {
                        
                    }
                }
                .padding(.horizontal, 17)
                .padding(.vertical, 18)
                .frame(width: 361, alignment: .topLeading)
                .cornerRadius(24)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Weight")
                            .font(.custom("Lato-Bold", size: 24))
                        Spacer()
                        Text("Week 3")
                            .font(.custom("Lato-Regulaer", size: 17))
                        Image(systemName: "chevron.forward")
                            .font(.system(size: 24))
                            .foregroundColor(.blueprimary)
                    }
                    
                }
                .padding(.horizontal, 17)
                .padding(.vertical, 18)
                .frame(width: 361, alignment: .topLeading)
                .cornerRadius(24)
            }
            
            .blur(radius: isExpanded ? 3 : 0)
            Spacer()
            HStack {
                Spacer()
                AddLogComponentView(isExpanded: $isExpanded)
                Spacer()
            }
            
        }
        .padding()
        Spacer()
    }
}

#Preview {
    GoalsScreenView()
}
