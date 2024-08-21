//
//  OnboardingView.swift
//  MC3
//
//  Created by mg0 on 14/08/24.
//

import SwiftUI

struct ExampleOnboardingView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: []
    ) private var users: FetchedResults<User>

    @State private var showingForm = false
    @State private var fullName = ""
    
    var body: some View {
        VStack {
            if users.isEmpty {
                // If no users exist, show the form to create a new user
                formView
            } else {
                // If a user exists, navigate to the next view
                NavigationView {
                    ExampleFoodListView()
                }
            }
        }
        .onAppear {
            // Check if users exist and handle navigation or form presentation
            if !users.isEmpty {
                // Navigate to the next page programmaticaly here (idk how)
            } else {
                showingForm = true
            }
        }
    }
    
    private var formView: some View {
        Form {
            Section(header: Text("Create New User")) {
                TextField("Full Name", text: $fullName)
                
                Button(action: createUser) {
                    Text("Create User")
                        .font(.title2)
                }
            }
        }
        .padding()
    }
    
    private func createUser() {
        let newUser = User(context: viewContext)
        newUser.fullName = fullName
        newUser.createdAt = Date()
        newUser.id = UUID()
        
        do {
            try viewContext.save()
        } catch {
            // Handle the error, e.g., show an alert
            print("Failed to save user: \(error.localizedDescription)")
        }
        
        // Navigate to the next view
        showingForm = false
    }
}

#Preview {
    ExampleOnboardingView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
