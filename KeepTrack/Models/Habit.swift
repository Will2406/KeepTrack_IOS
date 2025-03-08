//
//  Habit.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 7/03/25.
//

import Foundation
import SwiftUI

struct Habit: Identifiable {
    var id: String
    var title: String
    var category: String
    var colorItem: Color
    var frequency: HabitFrequency
    var counter: Int
    var maxCounter: Int
    var selectedWeekDays: [Int] = []
    var lastResetDate: Date = Date()
    var history: [String: HabitHistory] = [:]
    
    func shouldShowToday() -> Bool {
        let calendar = Calendar.current
        
        switch frequency {
        case .daily:
            return true
        case .weekly:
            var weekday = calendar.component(.weekday, from: Date()) - 1
            if weekday == 0 { weekday = 7 }
            
            return selectedWeekDays.contains(weekday)
        }
    }
    
    func shouldReset() -> Bool {
        let calendar = Calendar.current
        let now = Date()
        
        switch frequency {
        case .daily:
            return !calendar.isDate(lastResetDate, inSameDayAs: now)
            
        case .weekly:
            if selectedWeekDays.isEmpty {
                return false
            }
            
            var weekday = calendar.component(.weekday, from: now) - 1
            if weekday == 0 { weekday = 7 }
            
            if let maxDay = selectedWeekDays.max(), weekday == maxDay {
                return !calendar.isDate(lastResetDate, inSameDayAs: now)
            }
            
            return false
        }
    }
    
    mutating func addToHistory(date: Date = Date(), completed: Bool) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        history[dateString] = HabitHistory(
            date: date,
            completed: completed,
            counter: counter
        )
    }
}
