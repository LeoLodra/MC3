//
//  ProfileScreenView.swift
//  MC3
//
//  Created by Leonardo Marhan on 21/08/24.
//

import SwiftUI
import CoreData

struct ProfileScreenView: View {
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \User.createdAt, ascending: false)],
        animation: .default)
    var users: FetchedResults<User>

    var body: some View {
        if let user = users.first {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("My Profile")
                        .font(.custom("Lato-Bold", size: 28))
                    Spacer()
                    Image(systemName: "pencil")
                        .font(.system(size: 24))
                        .foregroundColor(.blueprimary)
                }
                
                Group {
                    Text("Name")
                        .font(.custom("Lato-Light", size: 15))
                    Text(user.fullName ?? "")
                        .font(.custom("Lato-Regular", size: 17))
                    
                    Text("Weight Before Pregnancy")
                        .font(.custom("Lato-Light", size: 15))
                    (Text("\(user.weight)") + Text(" Kg"))
                        .font(.custom("Lato-Regular", size: 17))
                    
                    Text("Height")
                        .font(.custom("Lato-Light", size: 15))
                    (Text("\(user.height)") + Text(" Cm"))
                        .font(.custom("Lato-Regular", size: 17))
                    
                    Text("When was the first day of your last menstrual period (LMP)?")
                        .font(.custom("Lato-Light", size: 15))
                    HStack {
                        Image(systemName: "calendar")
                        Text(dateFormatter.string(from: user.lastHaidAt ?? Date()))
                            .font(.custom("Lato-Regular", size: 17))
                    }
                    
                    Text("Date of Birth")
                        .font(.custom("Lato-Light", size: 15))
                    HStack {
                        Image(systemName: "calendar")
                        Text(dateFormatter.string(from: user.birthday ?? Date()))
                            .font(.custom("Lato-Regular", size: 17))
                    }
                }
                
                Spacer()
            }
            .padding()
        } else {
            Text("No user data found.")
                .padding()
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

#Preview {
    ProfileScreenView()
}
