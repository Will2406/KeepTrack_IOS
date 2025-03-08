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
                    Text(category)
                        .frame(maxWidth:.infinity,alignment: .leading)
                        .foregroundColor(colorItem)
                        .opacity(0.9)
                        .bold()
                }.frame(maxWidth: .infinity)
                
                CounterHabitButton(
                    maxCounterValue: maxCounterValue,
                    backgrounColor: colorItem,
                    counter: counter,
                    onIncrement: {
                        viewModel.incrementHabitCounter(
                            habitId: id,
                            currentCounter: counter,
                            maxCounter: maxCounterValue
                        )
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
            counter: 2
        )
        .environmentObject(HabitViewModel())
        
        HabitItem(
            id: "2",
            title: "Ir al Gym",
            category: "Salud",
            colorItem: .red,
            maxCounterValue: 8,
            counter: 3
        )
        .environmentObject(HabitViewModel())
    }
}
