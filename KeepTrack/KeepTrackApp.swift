//
//  KeepTrackApp.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 17/11/24.
//

import SwiftUI


@main
struct HabitsApp: App {
    
    init() {
        setupFirebase()
    }
    
    func setupFirebase() {
        FirebaseManager.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HabitNavigationView()
        }
    }
}
