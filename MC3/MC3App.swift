//
//  MC3App.swift
//  MC3
//
//  Created by Leonardo Marhan on 13/08/24.
//

import SwiftUI
import SwiftData

@main
struct MC3App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            UIKitHostingController()
        }
        .modelContainer(sharedModelContainer)
    }
}

struct UIKitHostingController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        // Return your UIKit view controller here
        return InitialScreenView()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No updates needed here
    }
}


// MARK: Running the Example App with CoreData, uncomment this
//import SwiftUI
//import CoreData
//
//@main
//struct MC3App: App {
//    let persistenceController = PersistenceController.shared
//
//    var body: some Scene {
//        WindowGroup {
//            ExampleOnboardingView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        }
//    }
//}
//
