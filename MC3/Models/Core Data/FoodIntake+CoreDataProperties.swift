//
//  FoodIntake+CoreDataProperties.swift
//  MC3
//
//  Created by mg0 on 14/08/24.
//
//

import Foundation
import CoreData


extension FoodIntake {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodIntake> {
        return NSFetchRequest<FoodIntake>(entityName: "FoodIntake")
    }

    @NSManaged public var intakeAt: Date?
    @NSManaged public var intakeAmount: Int64
    @NSManaged public var foodId: Int64
    @NSManaged public var id: UUID?
    @NSManaged public var user: User?

}

extension FoodIntake : Identifiable {

}
