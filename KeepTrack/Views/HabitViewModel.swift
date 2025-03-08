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
    
    private var db = Firestore.firestore()
    private var habitsListener: ListenerRegistration?
    
    init() {
        setupHabitsListener()
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
                        let counter = data["counter"] as? Int,
                        let frequency = HabitFrequency(rawValue: frequencyString)
                    else {
                        return nil
                    }
                    
                    return Habit(
                        id: document.documentID,
                        title: title,
                        category: category,
                        colorItem: Color(hex: colorHex),
                        frequency: frequency,
                        counter: counter
                    )
                }
                
                self.isLoading = false
            }
    }
    
    func addHabit(habit: Habit) {
        isLoading = true
        
        let colorHex = habit.colorItem.toHex() ?? "#FF0000"
        
        let habitData: [String: Any] = [
            "title": habit.title,
            "category": habit.category,
            "colorHex": colorHex,
            "frequency": habit.frequency.rawValue,
            "counter": habit.counter,
            "createdAt": FieldValue.serverTimestamp()
        ]
        
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
}
