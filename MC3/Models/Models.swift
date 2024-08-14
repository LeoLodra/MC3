//
//  Models.swift
//  MC3
//
//  Created by mg0 on 14/08/24.
//

import Foundation

// MARK: JSON

struct Food: Codable, Identifiable {
    let id: Int
    let title: String
    let edibleStatus: EdibleStatus
    let servingSizeUnit: String
    let servingSize: Int
    let calories: Int
    let protein: Float
    let fiber: Float
    let iron: Float
    let calcium: Float
    let vitaminD: Float
    let vitaminA: Float
    let folate: Float
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case edibleStatus = "edible_status"
        case servingSizeUnit = "serving_size_unit"
        case servingSize = "serving_size"
        case calories, protein, fiber, iron, calcium
        case vitaminD = "vitamin_d"
        case vitaminA = "vitamin_a"
        case folate
    }
}

enum EdibleStatus: String, Codable {
    case safe
    case caution
    case tinyPortionsOnly = "tiny_portions_only"
    case notAllowed = "not_allowed"
}

struct FoodTag: Codable, Identifiable {
    let id: Int
    let title: String
}

// MARK: Deprecated

//struct UserStruct: Codable, Equatable, Identifiable {
//    let id: UUID
//    let fullName: String
//
//    // Pregnancy
//    let lastHaidAt: Date
//    let fetusCount: Int
//
//    // Physical
//    let weight: Float
//    let height: Int
//    let birthday: Date
//
//    enum CodingKeys: String, CodingKey {
//        case id, fullName, lastHaidAt, fetusCount, weight, height, birthday
//    }
//
//    init(fullName: String, lastHaidAt: Date, fetusCount: Int = 1, weight: Float, height: Int, birthday: Date) {
//        self.id = UUID()
//        self.fullName = fullName
//        self.lastHaidAt = lastHaidAt
//        self.fetusCount = fetusCount
//        self.weight = weight
//        self.height = height
//        self.birthday = birthday
//    }
//}
//
//struct WeightLogStruct: Codable, Equatable, Identifiable {
//    let id: UUID
//    let userId: Int
//
//    let weight: Float
//    let logDate: Date
//
//    enum CodingKeys: String, CodingKey {
//        case id, userId, weight, logDate
//    }
//
//    init(userId: Int, weight: Float, logDate: Date) {
//        self.id = UUID()
//        self.userId = userId
//        self.weight = weight
//        self.logDate = logDate
//    }
//}
//
//struct FoodIntakeStruct: Codable, Equatable, Identifiable {
//    let id: Int
//    let userId: Int
//
//    let foodId: Int
//    let intakeAt: Date
//    let intakeAmount: Int
//
//    enum CodingKeys: String, CodingKey {
//        case id, userId, foodId, intakeAt, intakeAmount
//    }
//
//    init(id: Int, userId: Int, foodId: Int, intakeAt: Date, intakeAmount: Int) {
//        self.id = id
//        self.userId = userId
//        self.foodId = foodId
//        self.intakeAt = intakeAt
//        self.intakeAmount = intakeAmount
//    }
//}

