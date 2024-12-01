//
//  ContentView.swift
//  HabitTracker
//
//  Created by James Clifford on 11/11/24.
//

import Foundation
import SwiftUICore
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = HabitTrackerViewModel()

    var body: some View {
        TabView {
            HabitSelectionView(viewModel: viewModel)
                .tabItem {
                    Label("Habits", systemImage: "list.bullet")
                }
            DailyTrackerView(viewModel: viewModel)
                .tabItem {
                    Label("Daily", systemImage: "calendar")
                }
            HabitTrendView(viewModel: viewModel)
                .tabItem {
                    Label("Trends", systemImage: "chart.bar.xaxis")
                }
        }
    }
}
