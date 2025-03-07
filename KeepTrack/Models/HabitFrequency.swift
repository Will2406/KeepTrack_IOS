//
//  HabitFrequency.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 7/03/25.
//

import Foundation


enum HabitFrequency: String, CaseIterable {
    case daily = "Diario"
    case weekly = "Semanal"
    case monthly = "Mensual"
    
    var intervalText: String {
        switch self {
        case .daily:
            return "al día"
        case .weekly:
            return "a la semana"
        case .monthly:
            return "al mes"
        }
    }
}
