//
//  HabitFrequency.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 7/03/25.
//

import Foundation


enum HabitFrequency: String, CaseIterable {
    case daily = "daily"
    case weekly = "weekly"
    
    var displayName: String {
        switch self {
        case .daily:
            return "Diario"
        case .weekly:
            return "Semanal"
        }
    }
    
    var intervalText: String {
        switch self {
        case .daily:
            return "veces al día"
        case .weekly:
            return "veces a la semana"
        }
    }
}
