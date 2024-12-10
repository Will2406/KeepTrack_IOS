//
//  ColorSelector.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 21/11/24.
//

import SwiftUI

struct ColorPicker: View {
    var index: Int = 0
    var color: Color = .black
    @Binding var selectedIndex: Int
    
    var isSelected: Bool {selectedIndex == index}
    
    var body: some View {
        
        let colorIndicator = isSelected ? Color.white : .clear
        
        ZStack {
            Circle()
                .frame(maxWidth: 48, maxHeight: 48)
                .foregroundColor(color)
                .onTapGesture {
                    selectedIndex = index
                }
            Circle()
                .frame(maxWidth: 24, maxHeight: 24)
                .foregroundColor(colorIndicator)
        }
    }
}
