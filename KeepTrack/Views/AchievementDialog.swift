//
//  AchievementDialog.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 8/03/25.
//

import SwiftUI

struct AchievementDialog: View {
    let habitTitle: String
    let habitColor: Color
    var onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .fill(habitColor)
                        .frame(width: 100, height: 100)
                    
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                }
                .padding(.top, 20)
                
                Text("¡Felicidades!")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                Text("Has completado tu hábito")
                    .font(.headline)
                    .foregroundColor(.gray200)
                
                Text("\"\(habitTitle)\"")
                    .font(.title3)
                    .bold()
                    .foregroundColor(habitColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Text("Sigue así, ¡vas por buen camino!")
                    .font(.subheadline)
                    .foregroundColor(.gray200)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button(action: onDismiss) {
                    Text("Continuar")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(
                                colors: [.pink700, .purple700],
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            )
                        )
                        .cornerRadius(8)
                }
                .padding(.top, 10)
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            }
            .frame(width: 300)
            .background(.gray800)
            .cornerRadius(16)
            .shadow(radius: 10)
        }
    }
}

#Preview {
    AchievementDialog(habitTitle: "Hacer ejercicio", habitColor: .blue) {
        print("Diálogo cerrado")
    }
}
