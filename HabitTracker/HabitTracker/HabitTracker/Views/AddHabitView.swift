//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by James Clifford on 11/11/24.
//

import Foundation
import SwiftUICore
import SwiftUI

struct AddHabitView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: HabitTrackerViewModel
    @State private var habitName: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Habit")) {
                    TextField("Habit Name", text: $habitName)
                }
                
                Button(action: {
                    if !habitName.isEmpty {
                        viewModel.addHabit(name: habitName)
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Add Habit")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .disabled(habitName.isEmpty)
            }
            .navigationTitle("Add Habit")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
