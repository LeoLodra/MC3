//
//  User+CoreDataProperties.swift
//  MC3
//
//  Created by mg0 on 14/08/24.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var lastHaidAt: Date?
    @NSManaged public var fetusCount: Int16
    @NSManaged public var weight: Float
    @NSManaged public var height: Int16
    @NSManaged public var birthday: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var weightLogs: WeightLog?
    @NSManaged public var foodIntakes: FoodIntake?

}

extension User : Identifiable {

}
