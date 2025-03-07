//
//  HabitViewModel.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 7/03/25.
//

import SwiftUI

class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = [
         Habit(id: "1", title: "Tomar Agua", category: "Salud", colorItem: .purple, frequency: .daily, counter: 8),
         Habit(id: "2", title: "Meditar", category: "Bienestar", colorItem: .blue, frequency: .daily, counter: 1),
         Habit(id: "3", title: "Ejercicio", category: "Fitness", colorItem: .orange, frequency: .weekly, counter: 3)
     ]
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    
    func fetchHabits() {

    }
    
    func addHabit(habit: Habit) {
        habits.append(habit)
        objectWillChange.send()
    }
}
