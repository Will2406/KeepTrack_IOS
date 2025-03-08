//
//  HabitHistory.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 8/03/25.
//

import Foundation


struct HabitHistory: Codable {
    var date: Date
    var completed: Bool
    var counter: Int
}
