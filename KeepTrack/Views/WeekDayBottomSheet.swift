//
//  WeekDayBottomSheet.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 8/03/25.
//

import SwiftUI

struct WeekDayBottomSheet: View {
    @ObservedObject var selection: WeekDaySelection
    @Binding var isPresented: Bool
    var onSave: ([Int]) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    isPresented = false
                }) {
                    Text("Cancelar")
                        .foregroundColor(.gray300)
                }
                
                Spacer()
                
                Text("Días de repetición")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    onSave(selection.getSelectedDaysIds())
                    isPresented = false
                }) {
                    Text("Guardar")
                        .foregroundColor(.pink700)
                        .bold()
                }
            }
            .padding()
            .background(Color.gray800)
            
            // Contenido
            ScrollView {
                WeekDaySelector(selection: selection)
                    .padding(.bottom, 20)
            }
        }
        .background(.backgroundApp)
        .cornerRadius(16, corners: [.topLeft, .topRight])
    }
}
