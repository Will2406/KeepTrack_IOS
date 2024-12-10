//
//  HabitView.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 10/12/24.
//

import SwiftUI

struct HabitView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            
            Text("Lista de Habitos")
                .font(.title)
                .foregroundColor(.white)
                .bold()
                .padding([.horizontal, .bottom], 16)
            
            List(0..<4){ index in
                HabitItem(
                    title: "Tomar Agua",
                    category: "Salud",
                    colorItem: .purple
                ).listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .scrollContentBackground(.hidden) 
                .layoutPriority(1)
                .listStyle(.plain)

            
            Button(
                action: {},
                label:{
                    Text("Agrega un habito")
                        .bold()
                }
            ).frame(maxWidth: .infinity)
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
        
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundApp)
            
    }
}

#Preview {
    HabitView()
}
