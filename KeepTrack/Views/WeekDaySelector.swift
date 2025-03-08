//
//  WeekDaySelector.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 8/03/25.
//

import SwiftUI

class WeekDaySelection: ObservableObject {
    @Published var weekDays: [WeekDay] = [
        WeekDay(id: 1, name: "Lunes", shortName: "L", isSelected: false),
        WeekDay(id: 2, name: "Martes", shortName: "M", isSelected: false),
        WeekDay(id: 3, name: "Miércoles", shortName: "X", isSelected: false),
        WeekDay(id: 4, name: "Jueves", shortName: "J", isSelected: false),
        WeekDay(id: 5, name: "Viernes", shortName: "V", isSelected: false),
        WeekDay(id: 6, name: "Sábado", shortName: "S", isSelected: false),
        WeekDay(id: 7, name: "Domingo", shortName: "D", isSelected: false)
    ]
    
    func toggleSelection(for id: Int) {
        if let index = weekDays.firstIndex(where: { $0.id == id }) {
            weekDays[index].isSelected.toggle()
        }
    }
    
    func getSelectedDaysIds() -> [Int] {
        return weekDays.filter { $0.isSelected }.map { $0.id }
    }
    
    func setSelectedDays(ids: [Int]) {
        for id in ids {
            if let index = weekDays.firstIndex(where: { $0.id == id }) {
                weekDays[index].isSelected = true
            }
        }
    }
}

struct WeekDaySelector: View {
    @ObservedObject var selection: WeekDaySelection
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Selecciona los días")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 8) {
                ForEach(selection.weekDays) { day in
                    Button(action: {
                        selection.toggleSelection(for: day.id)
                    }) {
                        Text(day.shortName)
                            .font(.system(size: 16, weight: .bold))
                            .frame(width: 40, height: 40)
                            .background(
                                Circle().fill(
                                day.isSelected ? AnyShapeStyle(LinearGradient(
                                    colors: [.pink700, .purple700],
                                    startPoint: .bottomLeading,
                                    endPoint: .topTrailing
                                )) : AnyShapeStyle(Color.gray200)
                            ))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(selection.weekDays) { day in
                    Button(action: {
                        selection.toggleSelection(for: day.id)
                    }) {
                        HStack {
                            Text(day.name)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Image(systemName: day.isSelected ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(day.isSelected ? .pink700 : .gray400)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color.gray700)
                        .cornerRadius(8)
                    }
                }
            }
        }
        .padding()
        .background(.backgroundApp)
    }
}

#Preview {
    let selection = WeekDaySelection()
    selection.weekDays[0].isSelected = true
    selection.weekDays[3].isSelected = true
    
    return WeekDaySelector(selection: selection)
        .background(.backgroundApp)
        .previewLayout(.sizeThatFits)
}
