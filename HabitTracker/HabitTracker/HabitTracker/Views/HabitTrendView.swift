//
//  HabitTrendView.swift
//  HabitTracker
//
//  Created by James Clifford on 11/11/24.
//

import Charts
import SwiftUI

struct HabitTrendView: View {
    @ObservedObject var viewModel: HabitTrackerViewModel

    var body: some View {
        Chart {
            ForEach(viewModel.dailyLogs, id: \.id) { log in  // Ensure logs are identifiable
                ForEach(log.completedHabits, id: \.self) { habitId in
                    if let habit = viewModel.habits.first(where: { $0.id == habitId }) {
                        BarMark(
                            x: .value("Date", log.date, unit: .day),
                            y: .value("Habit", habit.name)
                        )
                        .foregroundStyle(.blue)
                    }
                }
            }
        }
        .frame(height: 300)
    }
}
