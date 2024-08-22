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
    
    @State private var selectedUser: User?
    
    var body: some View {
        if let user = users.first {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("My Profile")
                        .font(.custom("Lato-Bold", size: 28))
                    Spacer()
                    NavigationLink(destination: EditProfileViewControllerRepresentable(user: $selectedUser)) {
                        Image(systemName: "pencil")
                            .font(.system(size: 24))
                            .foregroundColor(.blueprimary)
                    }
                }
                
                Group {
                    Text("Name")
                        .font(.custom("Lato-Light", size: 15))
                    Text(user.fullName ?? "")
                        .font(.custom("Lato-Regular", size: 17))
                    
                    Text("Weight Before Pregnancy")
                        .font(.custom("Lato-Light", size: 15))
                    (Text(String(format: "%.0f", user.weight)) + Text(" Kg"))
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
            .onAppear {
                selectedUser = user
            }
            
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


struct EditProfileViewControllerRepresentable: UIViewControllerRepresentable {
    @Environment(\.managedObjectContext) var managedContext: NSManagedObjectContext
    @Binding var user: User?
    
    func makeUIViewController(context: Context) -> EditProfileScreenView {
        let viewController = EditProfileScreenView()
        viewController.managedContext = managedContext
        viewController.user = user
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: EditProfileScreenView, context: Context) {
    }
}

#Preview {
    ProfileScreenView()
}
