//
//  WeightLog+CoreDataProperties.swift
//  MC3
//
//  Created by mg0 on 14/08/24.
//
//

import Foundation
import CoreData


extension WeightLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeightLog> {
        return NSFetchRequest<WeightLog>(entityName: "WeightLog")
    }

    @NSManaged public var weight: Float
    @NSManaged public var logDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var user: User?

}

extension WeightLog : Identifiable {

}
