//
//  CounterHabitView.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 27/11/24.
//

import SwiftUI

struct CounterHabitButton: View {
    let maxCounterValue: Int
    let backgrounColor: Color
    let counter: Int
    let onIncrement: () -> Void
    
    var body: some View {
        var valuePercentView: CGFloat {
            (CGFloat(counter) / CGFloat(maxCounterValue)) * 120
        }
        
        ZStack{
            
            HStack{
                HStack{
                    
                }.frame(maxWidth: CGFloat(valuePercentView) ,maxHeight: .infinity)
                    .background(backgrounColor)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6), value: counter)

                
                Spacer()
                    .frame(maxWidth: CGFloat(120 - valuePercentView))
            }.cornerRadius(6)
            .padding(3)
            
            HStack{
                Text("\(counter)/\(maxCounterValue)")
                    .padding(.leading, 8)
                    .bold()
                    .foregroundColor(.white)
                Spacer()
                HStack{
                    Text("+")
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                        .padding(.bottom, 4)
                }.frame(maxWidth: 44,maxHeight: .infinity)
                    .background(.white.opacity(0.45))
                    .cornerRadius(8)
                    .onTapGesture {
                        if(counter < maxCounterValue){
                            onIncrement()
                        }
                    }
                    
                
            }.frame(maxWidth: .infinity,maxHeight: .infinity)
                .padding(8)
       
        }.frame(maxWidth: 120, maxHeight: 60)
            .background(.black)
            .cornerRadius(8)
    }
}

#Preview {
    CounterHabitButton(
        maxCounterValue: 5,
        backgrounColor: .blue,
        counter: 2,
        onIncrement: {}
    )
}
