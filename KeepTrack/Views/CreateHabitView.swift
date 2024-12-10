//
//  CreateHabit.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 17/11/24.
//

import SwiftUI

struct CreateHabitView: View {
    
    @State private var nameValue: String = ""
    @State private var categoryValue: String = ""
    @State private var frequencySelected: Int = 1
    @State private var counterValue: String = ""
    @State private var colorSelected: Int = 1
    
    
    private let colors = [
        ColorItem(id: 1, color: Color.red),
        ColorItem(id: 2, color: Color.blue),
        ColorItem(id: 3, color: Color.green),
        ColorItem(id: 4, color: Color.yellow),
        ColorItem(id: 5, color: Color.orange),
    ]
    
    var body: some View {
        ScrollView{
            VStack{
                Text("Crear Habito")
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
                    title: "Categoria",
                    placeholder: "Salud",
                    text: $categoryValue
                ).padding([.horizontal, .top], 12)
                
                // Frequency Section
                SubTitle(text: "Frequencia",padding: 12)
                HStack{
                    ButtonPicker(index: 1,text: "Diario",selectedIndex: $frequencySelected)
                    ButtonPicker(index: 2,text: "Semanal",selectedIndex: $frequencySelected)
                    ButtonPicker(index: 3,text: "Mensual",selectedIndex: $frequencySelected)
                }.padding(.horizontal, 12)
                
                // Intervalo Section
                SubTitle(text: "Intervalo", padding: 12)
                CounterSection(subfixText: " al día", text: $counterValue)
                    .padding(.horizontal, 12)
                
                // Color Section
                SubTitle(text: "Color", padding: 12)
                ScrollView(.horizontal){
                    LazyHStack{
                        ForEach(colors){ current in
                            ColorPicker(index: current.id, color: current.color, selectedIndex: $colorSelected)
                        }
                    }
                }.frame(height: 50)
                    .padding(.horizontal, 12)
                
                Button(
                    action: {},
                    label:{
                        Text("Guardar")
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
                    .padding(.top, 24)
                
                
            }
        }.background(.backgroundApp)
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