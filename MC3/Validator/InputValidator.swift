//
//  InputValidator.swift
//  MC3
//
//  Created by Leonardo Marhan on 21/08/24.
//

import Foundation

class InputValidator {
    
    static func isValidName(_ name: String) -> Bool {
        return !name.isEmpty
    }
    
    static func isValidWeight(_ weight: String) -> Bool {
        guard let weightValue = Double(weight) else { return false }
        return weightValue > 0
    }
    
    static func isValidDate(_ date: Date) -> Bool {
        return date <= Date()
    }
    
    static func isValidHeight(_ height: String) -> Bool {
        guard let heightValue = Double(height) else { return false }
        return heightValue > 0
    }
}

