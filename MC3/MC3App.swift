//
//  MC3App.swift
//  MC3
//
//  Created by Leonardo Marhan on 13/08/24.
//

//import SwiftUI
//import SwiftData
//
//@main
//struct MC3App: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//        .modelContainer(sharedModelContainer)
//    }
//}


// MARK: Running the Example App with CoreData, uncomment this
import SwiftUI
import UIKit
import CoreData

@main
struct MC3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NutrientDetailView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct InitialViewControllerRepresentable: UIViewControllerRepresentable {
    @Environment(\.managedObjectContext) private var viewContext

    func makeUIViewController(context: Context) -> some UIViewController {
        let initialScreenView = InitialScreenView()
        initialScreenView.managedContext = viewContext
        let navigationController = UINavigationController(rootViewController: initialScreenView)
        return navigationController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}


