//
//  CreateHabit.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 17/11/24.
//

import SwiftUI

import SwiftUI

struct CreateHabitView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: HabitViewModel
    
    @State private var nameValue: String = ""
    @State private var categoryValue: String = ""
    @State private var frequencySelected: Int = 1
    @State private var counterValue: String = ""
    @State private var colorSelected: Int = 1
    @State private var showWeekDayBottomSheet = false
    @State private var weekDaySelection = WeekDaySelection()
    
    private let colors = [
        ColorItem(id: 1, color: Color.red),
        ColorItem(id: 2, color: Color.blue),
        ColorItem(id: 3, color: Color.green),
        ColorItem(id: 4, color: Color.yellow),
        ColorItem(id: 5, color: Color.orange),
    ]
    
    private func getSelectedColor() -> Color {
        return colors.first { $0.id == colorSelected }?.color ?? .red
    }
    
    private func getSelectedFrequency() -> HabitFrequency {
        switch frequencySelected {
        case 1:
            return .daily
        case 2:
            return .weekly
        default:
            return .daily
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Crear Hábito")
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.horizontal, 12)
                
                // Fields Section
                TextFieldApp(
                    title: "Nombre",
                    placeholder: "Ej : Hacer ejercicio",
                    text: $nameValue
                ).padding([.horizontal, .top], 12)
                
                TextFieldApp(
                    title: "Categoría",
                    placeholder: "Salud",
                    text: $categoryValue
                ).padding([.horizontal, .top], 12)
                
                // Frequency Section
                SubTitle(text: "Frecuencia", padding: 12)
                HStack {
                    ButtonPicker(index: 1, text: "Diario", selectedIndex: $frequencySelected)
                    ButtonPicker(index: 2, text: "Semanal", selectedIndex: $frequencySelected)
                    Spacer()
                }.padding(.horizontal, 12)
                
                if frequencySelected == 2 {
                    SubTitle(text: "Días de la semana", padding: 12)
                    Button(action: {
                        showWeekDayBottomSheet = true
                    }) {
                        HStack {
                            Text(weekDaySelection.getSelectedDaysIds().isEmpty ?
                                 "Seleccionar días" :
                                 "\(weekDaySelection.getSelectedDaysIds().count) días seleccionados")
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "calendar")
                                .foregroundColor(.pink700)
                        }
                        .padding()
                        .background(Color.gray700)
                        .cornerRadius(8)
                    }
                    .padding(.horizontal, 12)
                }
                
                // Intervalo Section
                SubTitle(text: "Intervalo", padding: 12)
                CounterSection(
                    subfixText: " \(getSelectedFrequency().intervalText)",
                    text: $counterValue
                )
                .padding(.horizontal, 12)
                
                // Color Section
                SubTitle(text: "Color", padding: 12)
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(colors) { current in
                            ColorPicker(index: current.id, color: current.color, selectedIndex: $colorSelected)
                        }
                    }
                }
                .frame(height: 50)
                .padding(.horizontal, 12)
                
                Button(
                    action: {
                        saveHabit()
                    },
                    label: {
                        Text("Guardar")
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
                .padding(.top, 24)
            }
        }
        .background(.backgroundApp)
        .navigationBarBackButtonHidden(false)
        .sheet(isPresented: $showWeekDayBottomSheet) {
            WeekDayBottomSheet(
                selection: weekDaySelection,
                isPresented: $showWeekDayBottomSheet,
                onSave: { _ in }
            )
            .presentationDetents([.height(450)])
            .presentationDragIndicator(.visible)
        }
    }
    
    private func saveHabit() {
        if nameValue.isEmpty {
             print("Error: El nombre del hábito no puede estar vacío")
             return
         }
         
         if categoryValue.isEmpty {
             print("Error: La categoría no puede estar vacía")
             return
         }
         
         if counterValue.isEmpty {
             print("Error: El contador no puede estar vacío")
             return
         }
         
         guard let counter = Int(counterValue) else {
             print("Error: El contador debe ser un número válido. Valor ingresado: \(counterValue)")
             return
         }
        
        
        let newHabit = Habit(
            id: UUID().uuidString,
            title: nameValue,
            category: categoryValue,
            colorItem: getSelectedColor(),
            frequency: getSelectedFrequency(),
            counter: 0,
            maxCounter: counter,
            selectedWeekDays: frequencySelected == 2 ? weekDaySelection.getSelectedDaysIds() : []
        )
        
        viewModel.addHabit(habit: newHabit)
        dismiss()
    }
}

struct SubTitle: View {
    var text: String = ""
    var padding: CGFloat? = 0
    
    var body: some View {
        Text(text)
            .foregroundStyle(.gray200)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.horizontal, .top], padding)
    }
}

#Preview {
    CreateHabitView()
}
