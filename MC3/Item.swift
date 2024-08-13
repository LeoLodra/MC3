//
//  Item.swift
//  MC3
//
//  Created by Leonardo Marhan on 13/08/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
