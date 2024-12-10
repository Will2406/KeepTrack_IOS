//
//  HabitItem.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 27/11/24.
//

import SwiftUI

struct HabitItem: View {
    var title: String
    var category: String
    var colorItem: Color
    @State var counterValue: Int = 0
    
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
                
                CounterHabitButton(maxCounterValue: 5, backgrounColor: colorItem, counter: $counterValue)
                
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
        HabitItem(title: "Tomar Agua", category: "Salud", colorItem: .purple)
        HabitItem(title: "Ir al Gym", category: "Salud", colorItem: .red)
    }
    
}
