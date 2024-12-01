//
//  Habit.swift
//  HabitTracker
//
//  Created by James Clifford on 11/11/24.
//

import Foundation
import FirebaseFirestore

struct Habit: Identifiable, Codable {
    var id: String
    var name: String
    var isSelected: Bool = false
}

struct DailyLog: Identifiable, Codable {
    var id: String
    var date: Date
    var completedHabits: [String] // List of habit IDs that are completed for the day
}
