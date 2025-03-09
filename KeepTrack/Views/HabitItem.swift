//
//  HabitItem.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 27/11/24.
//

import SwiftUI

struct HabitItem: View {
    @EnvironmentObject var viewModel: HabitViewModel
    
    var id: String
    var title: String
    var category: String
    var colorItem: Color
    var maxCounterValue: Int
    var counter: Int
    var frequency: HabitFrequency
    var selectedWeekDays: [Int]
    
    @State private var showWeekDayBottomSheet = false
    @State private var weekDaySelection = WeekDaySelection()
    
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Text(title)
                        .frame(maxWidth:.infinity,alignment: .leading)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .bold()
                    Spacer()
                        .frame(height: 4)
                    HStack {
                        Text(category)
                            .foregroundColor(colorItem)
                            .opacity(0.9)
                            .bold()
                        
                        if frequency == .weekly {
                            Button(action: {
                                weekDaySelection.weekDays.indices.forEach { index in
                                    weekDaySelection.weekDays[index].isSelected = false
                                }
                                weekDaySelection.setSelectedDays(ids: selectedWeekDays)
                                showWeekDayBottomSheet = true
                            }) {
                                HStack(spacing: 4) {
                                    Text("Editar días")
                                        .font(.caption)
                                    Image(systemName: "calendar.badge.clock")
                                        .font(.caption)
                                }
                                .foregroundColor(.gray300)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 2)
                                .background(.gray700)
                                .cornerRadius(4)
                            }
                        }
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }.frame(maxWidth: .infinity)
                
                CounterHabitButton(
                    maxCounterValue: maxCounterValue,
                    backgrounColor: colorItem,
                    counter: counter,
                    onIncrement: {
                        if shouldShowToday() {
                            viewModel.incrementHabitCounter(
                                habitId: id,
                                currentCounter: counter,
                                maxCounter: maxCounterValue
                            )
                        }
                    }
                )
                
            }.frame(maxWidth: .infinity)
                .padding([.horizontal], 12)
            
        }.frame(maxWidth: .infinity)
            .frame(height: 80)
            .background(.gray800)
            .cornerRadius(8)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .opacity(shouldShowToday() ? 1.0 : 0.5)
            .sheet(isPresented: $showWeekDayBottomSheet) {
                WeekDayBottomSheet(
                    selection: weekDaySelection,
                    isPresented: $showWeekDayBottomSheet,
                    onSave: { selectedDays in
                        viewModel.updateHabitWeekDays(habitId: id, selectedDays: selectedDays)
                    }
                )
                .presentationDetents([.height(450)])
                .presentationDragIndicator(.visible)
            }
    }
    
    private func shouldShowToday() -> Bool {
        let today = Calendar.current.component(.weekday, from: Date())
        let adjustedDay = today == 1 ? 7 : today - 1
        
        if frequency != .weekly {
            return true
        }
        
        if selectedWeekDays.isEmpty {
            return true
        }
        
        return selectedWeekDays.contains(adjustedDay)
    }
}

#Preview {
    VStack{
        HabitItem(
            id: "1",
            title: "Tomar Agua",
            category: "Salud",
            colorItem: .purple,
            maxCounterValue: 5,
            counter: 2,
            frequency: .daily,
            selectedWeekDays: []
        )
        .environmentObject(HabitViewModel())
        
        HabitItem(
            id: "2",
            title: "Ir al Gym",
            category: "Salud",
            colorItem: .red,
            maxCounterValue: 8,
            counter: 3,
            frequency: .weekly,
            selectedWeekDays: [1, 3, 5]
        )
        .environmentObject(HabitViewModel())
    }
}
