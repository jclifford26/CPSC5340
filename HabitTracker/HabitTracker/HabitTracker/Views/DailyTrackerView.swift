//
//  DailyTrackerView.swift
//  HabitTracker
//
//  Created by James Clifford on 11/11/24.
//

import SwiftUICore
import SwiftUI

struct DailyTrackerView: View {
    @ObservedObject var viewModel: HabitTrackerViewModel

    var body: some View {
        VStack {
            Text("Today's Habits")
                .font(.title)
            List(viewModel.habits.filter { $0.isSelected }) { habit in
                HStack {
                    Text(habit.name)
                    Spacer()
                    if viewModel.dailyLogs.contains(where: { log in
                        log.completedHabits.contains(habit.id)
                    }) {
                        Image(systemName: "checkmark")
                    }
                }
                .onTapGesture {
                    viewModel.toggleHabitCompletion(habitId: habit.id)
                }
            }
        }
    }
}
