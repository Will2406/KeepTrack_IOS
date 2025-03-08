//
//  HabitView.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 10/12/24.
//

import SwiftUI

struct HabitView: View {
    @EnvironmentObject var viewModel: HabitViewModel
    @State private var showCreateHabit = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Lista de Hábitos")
                .font(.title)
                .foregroundColor(.white)
                .bold()
                .padding([.horizontal, .bottom], 16)
            
            List {
                ForEach(viewModel.habits) { habit in
                    HabitItem(
                        title: habit.title,
                        category: habit.category,
                        colorItem: habit.colorItem,
                        maxCounterValue: habit.counter
                    )
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollContentBackground(.hidden)
            .layoutPriority(1)
            .listStyle(.plain)
            
            Button(
                action: {
                    showCreateHabit = true
                },
                label: {
                    Text("Agrega un hábito")
                        .bold()
                }
            )
            .frame(maxWidth: .infinity)
            .frame(height: 64)
            .foregroundColor(.white)
            .background(
                LinearGradient(
                    colors: [.pink700, .purple700],
                    startPoint: .bottomLeading,
                    endPoint: .topTrailing
                )
            )
            .cornerRadius(8)
            .padding([.horizontal], 12)
            .padding([.bottom], 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundApp)
        .navigationDestination(isPresented: $showCreateHabit) {
            CreateHabitView()
                   .environmentObject(viewModel)
        }
        .onAppear {
            viewModel.setupHabitsListener()
        }
    }
}

#Preview {
    HabitView()
}
