//
//  SelectorButton.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 17/11/24.
//

import SwiftUI

struct ButtonPicker: View {
    let index: Int
    let text: String
    @Binding var selectedIndex: Int
    
    var isSelected: Bool { selectedIndex == index }
    
    var body: some View {
        
        let backgroundButton = isSelected
              ? AnyView(
                  LinearGradient(
                      colors: [.pink700, .purple700],
                      startPoint: .bottomLeading,
                      endPoint: .topTrailing
                  )
              ): AnyView(Color.clear)
          
        let foregroundButton = !isSelected
              ? AnyView(
                  RoundedRectangle(cornerRadius: 8)
                      .stroke(.purple700, lineWidth: 2)
              ): AnyView(EmptyView())
        
        Button(
            action: {
                selectedIndex = index
            },
            label: {
                Text(text)
                    .frame(maxWidth: .infinity,maxHeight: 64)
                    .bold()
                    .foregroundColor(.white)
                    .overlay(foregroundButton)
            }
        ).frame(maxWidth: .infinity)
            .frame(height: 64)
            .background(backgroundButton)
            .cornerRadius(8)
    }
}
