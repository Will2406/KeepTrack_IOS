//
//  WeekDay.swift
//  KeepTrack
//
//  Created by Daniel Quispe Herrera on 8/03/25.
//

struct WeekDay: Identifiable, Hashable {
    var id: Int
    var name: String
    var shortName: String
    var isSelected: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: WeekDay, rhs: WeekDay) -> Bool {
        return lhs.id == rhs.id
    }
}
