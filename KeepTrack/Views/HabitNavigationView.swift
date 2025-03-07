//
//  HabitNavigationView.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 7/03/25.
//

import Foundation
import SwiftUI


struct HabitNavigationView: View {
    @StateObject private var viewModel = HabitViewModel()
    
    var body: some View {
        NavigationStack {
            HabitView()
                .environmentObject(viewModel)
        }
    }
}
