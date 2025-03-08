//
//  HabitViewModel.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 7/03/25.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showAchievementDialog: Bool = false
    @Published var completedHabit: Habit?
    
    private var db = Firestore.firestore()
    private var habitsListener: ListenerRegistration?
    
    init() {
        setupHabitsListener()
        checkAndResetHabits()
        scheduleResetCheck()
    }
    
    deinit {
        habitsListener?.remove()
    }
    
    func setupHabitsListener() {
        isLoading = true
        
        habitsListener = db.collection("habits")
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                
                if let error = error {
                    self.errorMessage = "Error cargando hábitos: \(error.localizedDescription)"
                    self.isLoading = false
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    self.isLoading = false
                    return
                }
                
                self.habits = documents.compactMap { document -> Habit? in
                    let data = document.data()
                    
                    guard
                        let title = data["title"] as? String,
                        let category = data["category"] as? String,
                        let colorHex = data["colorHex"] as? String,
                        let frequencyString = data["frequency"] as? String,
                        let maxcounter = data["maxCounter"] as? Int,
                        let initCounter = data["counter"] as? Int,
                        let frequency = HabitFrequency(rawValue: frequencyString)
                    else {
                        return nil
                    }
                    
                    let selectedWeekDays = data["selectedWeekDays"] as? [Int] ?? []
                    
                    let lastResetTimestamp = data["lastResetDate"] as? Timestamp ?? Timestamp(date: Date())
                    let lastResetDate = lastResetTimestamp.dateValue()
                    
                    var history: [String: HabitHistory] = [:]
                    if let historyData = data["history"] as? [String: [String: Any]] {
                        for (dateString, historyEntry) in historyData {
                            if let counterValue = historyEntry["counter"] as? Int,
                               let completedValue = historyEntry["completed"] as? Bool,
                               let dateTimestamp = historyEntry["date"] as? Timestamp {
                                history[dateString] = HabitHistory(
                                    date: dateTimestamp.dateValue(),
                                    completed: completedValue,
                                    counter: counterValue
                                )
                            }
                        }
                    }
                    
                    return Habit(
                        id: document.documentID,
                        title: title,
                        category: category,
                        colorItem: Color(hex: colorHex),
                        frequency: frequency,
                        counter: initCounter,
                        maxCounter: maxcounter,
                        selectedWeekDays: selectedWeekDays,
                        lastResetDate: lastResetDate,
                        history: history
                    )
                }
                
                self.isLoading = false
            }
    }
    
    func addHabit(habit: Habit) {
        isLoading = true
        
        let colorHex = habit.colorItem.toHex() ?? "#FF0000"
        
        var habitData: [String: Any] = [
            "title": habit.title,
            "category": habit.category,
            "colorHex": colorHex,
            "frequency": habit.frequency.rawValue,
            "counter": 0,
            "maxCounter": habit.maxCounter,
            "lastResetDate": FieldValue.serverTimestamp(),
            "createdAt": FieldValue.serverTimestamp()
        ]
        
        // Añadir días seleccionados si es semanal
        if habit.frequency == .weekly {
            habitData["selectedWeekDays"] = habit.selectedWeekDays
        }
        
        db.collection("habits").addDocument(data: habitData) { [weak self] error in
            guard let self = self else { return }
            
            self.isLoading = false
            
            if let error = error {
                self.errorMessage = "Error guardando hábito: \(error.localizedDescription)"
            }
        }
    }
    
    func deleteHabit(habitId: String) {
        isLoading = true
        
        db.collection("habits").document(habitId).delete { [weak self] error in
            guard let self = self else { return }
            
            self.isLoading = false
            
            if let error = error {
                self.errorMessage = "Error eliminando hábito: \(error.localizedDescription)"
            }
        }
    }
    
    func incrementHabitCounter(habitId: String, currentCounter: Int, maxCounter: Int) {
        if currentCounter >= maxCounter {
            return
        }
        
        let newCounter = currentCounter + 1
        
        if let habitIndex = habits.firstIndex(where: { $0.id == habitId }) {
            var updatedHabit = habits[habitIndex]
            updatedHabit.counter = newCounter
            
            let isCompleted = newCounter >= maxCounter
            
            updatedHabit.addToHistory(completed: isCompleted)
            
            let historyData = convertHistoryToFirestore(updatedHabit.history)
            
            let updates: [String: Any] = [
                "counter": newCounter,
                "history": historyData
            ]
            
            db.collection("habits").document(habitId).updateData(updates) { [weak self] error in
                guard let self = self else { return }
                
                if let error = error {
                    self.errorMessage = "Error actualizando contador: \(error.localizedDescription)"
                } else if isCompleted {
                    self.completedHabit = updatedHabit
                    self.showAchievementDialog = true
                }
            }
        }
    }
    
    func resetHabitCounter(habitId: String) {
        if let habitIndex = habits.firstIndex(where: { $0.id == habitId }) {
            let updates: [String: Any] = [
                "counter": 0,
                "lastResetDate": FieldValue.serverTimestamp()
            ]
            
            db.collection("habits").document(habitId).updateData(updates) { [weak self] error in
                guard let self = self else { return }
                
                if let error = error {
                    self.errorMessage = "Error restableciendo contador: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func updateHabitWeekDays(habitId: String, selectedDays: [Int]) {
        db.collection("habits").document(habitId).updateData([
            "selectedWeekDays": selectedDays
        ]) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessage = "Error actualizando días: \(error.localizedDescription)"
            }
        }
    }
    
    func checkAndResetHabits() {
        for habit in habits {
            if habit.shouldReset() {
                db.collection("habits").document(habit.id).updateData([
                    "counter": 0,
                    "lastResetDate": FieldValue.serverTimestamp()
                ]) { [weak self] error in
                    if let error = error, let self = self {
                        self.errorMessage = "Error reiniciando hábito: \(error.localizedDescription)"
                    }
                }
            }
        }
    }
    
    private func scheduleResetCheck() {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        components.day! += 1
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        if let midnight = calendar.date(from: components) {
            let timeInterval = midnight.timeIntervalSince(Date())
            
            DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) { [weak self] in
                self?.checkAndResetHabits()
                self?.scheduleResetCheck()
            }
        }
    }
    
    private func convertHistoryToFirestore(_ history: [String: HabitHistory]) -> [String: [String: Any]] {
        var result: [String: [String: Any]] = [:]
        
        for (dateString, historyEntry) in history {
            result[dateString] = [
                "date": Timestamp(date: historyEntry.date),
                "completed": historyEntry.completed,
                "counter": historyEntry.counter
            ]
        }
        
        return result
    }
}
