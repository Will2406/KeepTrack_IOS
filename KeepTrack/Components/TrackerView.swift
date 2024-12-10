//
//  DayTrackerView.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 26/11/24.
//

import SwiftUI


struct DayTrackerView: View {
    var backgroundColor: Color
    var percentOpacity: Double
    
    var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(backgroundColor)
            .opacity(percentOpacity)
            .cornerRadius(2)
    }
}

struct WeeklyTrackerView: View {
    var backgroundColor: Color
    
    var body: some View {
        VStack(spacing: 2){
            ForEach(0..<7){ day in
                DayTrackerView(backgroundColor: backgroundColor, percentOpacity: 0.5)
                    .listRowInsets(EdgeInsets())
            }
        }.frame(maxWidth: .infinity,maxHeight: 100)
    }
}

struct PeriodTrackerView: View {
    var backgroundColor: Color

    var body: some View {
        HStack(spacing: 2){
            ForEach(0..<24){ day in
                WeeklyTrackerView(backgroundColor: backgroundColor)
            }
        }
    }
}


#Preview {
    PeriodTrackerView(backgroundColor: .red)
}

#Preview {
    WeeklyTrackerView(backgroundColor: .red)
}

#Preview {
    DayTrackerView(backgroundColor: .red, percentOpacity: 40.0)
}
