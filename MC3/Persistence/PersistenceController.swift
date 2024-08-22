//
//  PersistenceController.swift
//  MC3
//
//  Created by mg0 on 14/08/24.
//
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "db_model_v1")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        do {
            // Create a sample user
            let user = User(context: viewContext)
            user.id = UUID()
            user.fullName = "Sample User"
            user.height = 170
            user.weight = 55
            user.lastHaidAt = Calendar.current.date(byAdding: .weekOfYear, value: -10, to: Date())!
            
            // Create some sample weight logs
            let calendar = Calendar.current
            let today = Date()
            
            for i in 0..<5 {
                let weightLog = WeightLog(context: viewContext)
                weightLog.id = UUID()
                weightLog.weight = Float.random(in: 55...57)
                weightLog.logDate = calendar.date(byAdding: .day, value: -i * 7, to: today)
                weightLog.user = user
            }
            
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

        return controller
    }()

    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
