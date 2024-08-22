//
//  WeightGainCalculator.swift
//  MC3
//
//  Created by mg0 on 22/08/24.
//

import Foundation

struct WeightGainCalculator {
    /// Everything according to this
    /// https://docs.google.com/spreadsheets/d/1DWBxDtO2pKillK0NBao9cZPIMiJnsne8SkKcYIeNQE0/edit?gid=0#gid=0

    enum BMICategory {
        case underweight
        case normalWeight
        case overweight
        case obese
    }

    struct WeightGainRange {
        let min: Double
        let max: Double
    }

    enum PregnancyType {
        case singleton
        case twins
    }

    enum Trimester {
        case first
        case second
        case third
    }

    static let totalWeightGainRanges: [PregnancyType: [BMICategory: WeightGainRange]] = [
        .singleton: [
            .underweight:  WeightGainRange(min: 12.5, max: 18.0),
            .normalWeight: WeightGainRange(min: 11.5, max: 16.0),
            .overweight:   WeightGainRange(min: 7.0,  max: 11.5),
            .obese:        WeightGainRange(min: 5.0,  max: 9.0)
        ],
        .twins: [
            .underweight:  WeightGainRange(min: 14.0, max: 22.7),
            .normalWeight: WeightGainRange(min: 16.8, max: 24.5),
            .overweight:   WeightGainRange(min: 14.1, max: 22.7),
            .obese:        WeightGainRange(min: 11.3, max: 19.1)
        ]
    ]
    
    static let firstTrimesterWeightGainRanges: [PregnancyType: [BMICategory: WeightGainRange]] = [
        .singleton: [
            .underweight:  WeightGainRange(min: 0.5, max: 2.0),
            .normalWeight: WeightGainRange(min: 0.5, max: 2.0),
            .overweight:   WeightGainRange(min: 0.5, max: 2.0),
            .obese:        WeightGainRange(min: 0.5, max: 2.0)
        ],
        .twins: [
            .underweight:  WeightGainRange(min: 2.0, max: 3.0),
            .normalWeight: WeightGainRange(min: 2.0, max: 3.0),
            .overweight:   WeightGainRange(min: 2.0, max: 3.0),
            .obese:        WeightGainRange(min: 2.0, max: 3.0)
        ]
    ]

    static var secondAndThirdTrimesterWeightGainRanges: [PregnancyType: [BMICategory: WeightGainRange]] {
        var result: [PregnancyType: [BMICategory: WeightGainRange]] = [:]
        
        for (pregnancyType, bmiCategories) in totalWeightGainRanges {
            result[pregnancyType] = [:]
            for (bmiCategory, totalRange) in bmiCategories {
                let firstTrimesterRange = firstTrimesterWeightGainRanges[pregnancyType]![bmiCategory]
                result[pregnancyType]![bmiCategory] = WeightGainRange(
                    min: totalRange.min - firstTrimesterRange!.min,
                    max: totalRange.max - firstTrimesterRange!.max
                )
            }
        }
        
        return result
    }

    
    /// Calculates the recommended daily calorie intake for weight gain
    /// https://www.calculator.net/pregnancy-weight-gain-calculator.html
    /// - Parameters:
    ///   - weight: Pre pregnancy weight in kilograms
    ///   - height: Height in centimeters
    ///   - weeks: Number of weeks pregnant
    ///   - isTwins: Whether the user is pregnant with twins
    /// - Returns: Recommended weight gain range
    static func calculateWeightGainRange(
        weight: Float,
        height: Int,
        weeks: Int,
        isTwins: Bool
    ) -> WeightGainRange {
        // 1. Calculate BMI before pregnancy
        let heightInMeters = Double(height) / 100.0
        let bmi = Double(weight) / (heightInMeters * heightInMeters)

        // 2. Categorize BMI
        let bmiCategory: BMICategory
        switch bmi {
        case ..<18.5:
            bmiCategory = .underweight
        case 18.5..<25.0:
            bmiCategory = .normalWeight
        case 25.0..<30.0:
            bmiCategory = .overweight
        default:
            bmiCategory = .obese
        }

        // 3. Categorize trimester
        let trimester: Trimester
        switch weeks {
        case 0...13:
            trimester = .first
        case 14...26:
            trimester = .second
        default:
            trimester = .third
        }

        // 4. Get the pregnancy type
        let pregnancyType: PregnancyType = isTwins ? .twins : .singleton

        // 5. Get the weight gain range for the trimester
        let weightGainRange: WeightGainRange
        if trimester == .first {
            // Week 2-13
            weightGainRange = firstTrimesterWeightGainRanges[pregnancyType]![bmiCategory]!
        } else {
            // Week 14-40
            weightGainRange = secondAndThirdTrimesterWeightGainRanges[pregnancyType]![bmiCategory]!
        }

        // 6. Calculate for current week
        let currentWeekWeightGainRange: WeightGainRange
        if trimester == .first {
            // Week 2-13
            currentWeekWeightGainRange = WeightGainRange(
                min: weightGainRange.min * Double((weeks - 1)) / 12,
                max: weightGainRange.max * Double((weeks - 1)) / 12
            )
        } else {
            // Week 14-41
            currentWeekWeightGainRange = WeightGainRange(
                min: min(firstTrimesterWeightGainRanges[pregnancyType]![bmiCategory]!.min + weightGainRange.min * Double((weeks - 13)) / 27, totalWeightGainRanges[pregnancyType]![bmiCategory]!.min),
                max: min(firstTrimesterWeightGainRanges[pregnancyType]![bmiCategory]!.max + weightGainRange.max * Double((weeks - 13)) / 27, totalWeightGainRanges[pregnancyType]![bmiCategory]!.max)
            )
        }
        return currentWeekWeightGainRange
    }
}

import SwiftUI
#Preview {
    let weight: Float = 50.0
    let height: Int = 158
    let weeks: Int = 70
    let isTwins: Bool = false
    
    let range = WeightGainCalculator.calculateWeightGainRange(
        weight: weight,
        height: height,
        weeks: weeks,
        isTwins: isTwins
    )
    
    return Text("Recommended weight gain range: \(range.min) - \(range.max) kg")
}
