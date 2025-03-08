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
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Lista de Hábitos")
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                    .padding([.horizontal, .bottom], 16)
                
                if viewModel.habits.isEmpty && !viewModel.isLoading {
                    VStack(spacing: 16) {
                        Image(systemName: "calendar.badge.plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray200)
                        
                        Text("No tienes hábitos todavía")
                            .font(.headline)
                            .foregroundColor(.gray200)
                        
                        Text("Comienza creando tu primer hábito")
                            .font(.subheadline)
                            .foregroundColor(.gray200)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.bottom, 80)
                } else {
                    List {
                        ForEach(viewModel.habits) { habit in
                            HabitItem(
                                id: habit.id,
                                title: habit.title,
                                category: habit.category,
                                colorItem: habit.colorItem,
                                maxCounterValue: habit.maxCounter,
                                counter: habit.counter
                            )
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                            .swipeActions {
                                Button(role: .destructive) {
                                    viewModel.deleteHabit(habitId: habit.id)
                                } label: {
                                    Label("Eliminar", systemImage: "trash")
                                }
                                
                                Button {
                                    viewModel.resetHabitCounter(habitId: habit.id)
                                } label: {
                                    Label("Reiniciar", systemImage: "arrow.counterclockwise")
                                }
                                .tint(.blue)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .scrollContentBackground(.hidden)
                    .layoutPriority(1)
                    .listStyle(.plain)
                }
                
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
            
            // Loading overlay
            if viewModel.isLoading {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
            }
            
            // Error alert
            if let errorMessage = viewModel.errorMessage {
                VStack {
                    Spacer()
                    Text(errorMessage)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .padding(.bottom, 100)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                viewModel.errorMessage = nil
                            }
                        }
                }
            }
        }
        .navigationDestination(isPresented: $showCreateHabit) {
            CreateHabitView()
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    HabitView()
        .environmentObject(HabitViewModel())
}
