//
//  CounterView.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 18/11/24.
//

import SwiftUI


struct CounterSection: View {
    let subfixText: String
    @Binding var text: String
    @State private var counter: Int = 0

    var body: some View {
        HStack{
            Text("\(counter) / \(subfixText)")
                .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .leading)
                .padding(16)
                .foregroundColor(.white)
                .background(.backgroundTextField)
                .cornerRadius(8)
            
            Button(
                action: {
                    if counter > 0 {
                        counter -= 1
                    }
                },
                label: {
                    Text("-")
                        .font(.system(size: 36))
                        .foregroundColor(.purple100)
                        .frame(maxWidth: 72, maxHeight: .infinity)
                        .background(.purple800)
                        .cornerRadius(8, corners: [.topLeft, .bottomLeft])
                }
            )
            Button(
                action: {counter += 1},
                label: {
                    Text("+")
                        .font(.system(size: 36))
                        .foregroundColor(.purple100)
                        .frame(maxWidth: 72, maxHeight: .infinity)
                        .background(.purple800)
                        .cornerRadius(8, corners: [.topRight, .bottomRight])
                }
            )
        }.frame(width: .infinity, height: 64)
    }
}
