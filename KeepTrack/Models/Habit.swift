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
}
