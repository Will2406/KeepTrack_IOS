//
//  EditText.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 17/11/24.
//

import SwiftUI

struct TextFieldApp: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack{
            SubTitle(text: title)
            TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.gray200))
                .keyboardType(.alphabet)
                .padding(16)
                .foregroundColor(.white)
                .frame(width: .infinity, height: 64)
                .background(.backgroundTextField)
                .cornerRadius(8)
               
        }
    }
}
