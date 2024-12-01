//
//  HabitTrackerViewModel.swift
//  HabitTracker
//
//  Created by James Clifford on 11/11/24.
//

import SwiftUI
import FirebaseFirestore

class HabitTrackerViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    @Published var dailyLogs: [DailyLog] = []

    private let db = Firestore.firestore()
    private var userId = "exampleUser" // This should ideally come from Firebase Authentication

    init() {
        loadHabits()
        loadDailyLogs()
    }

    func loadHabits() {
        db.collection("users").document(userId).collection("habits").getDocuments { snapshot, error in
            if let error = error {
                print("Error loading habits: \(error)")
                return
            }
            self.habits = snapshot?.documents.compactMap { try? $0.data(as: Habit.self) } ?? []
        }
    }
    
    func saveHabit(_ habit: Habit) {
        // Ensure userId exists and is valid
        guard !userId.isEmpty else { return }

        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userId).collection("habits")

        do {
            try userRef.document(habit.id ?? UUID().uuidString).setData(from: habit)
        } catch {
            print("Error saving habit: \(error)")
        }
    }


    func loadDailyLogs() {
        db.collection("users").document(userId).collection("dailyLogs").getDocuments { snapshot, error in
            if let error = error {
                print("Error loading logs: \(error)")
                return
            }
            self.dailyLogs = snapshot?.documents.compactMap { try? $0.data(as: DailyLog.self) } ?? []
        }
    }

    func toggleHabitCompletion(habitId: String) {
        let today = Date()
        if let index = dailyLogs.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: today) }) {
            if let habitIndex = dailyLogs[index].completedHabits.firstIndex(of: habitId) {
                dailyLogs[index].completedHabits.remove(at: habitIndex)
            } else {
                dailyLogs[index].completedHabits.append(habitId)
            }
            saveDailyLog(dailyLogs[index])
        } else {
            let newLog = DailyLog(id: UUID().uuidString, date: today, completedHabits: [habitId])
            dailyLogs.append(newLog)
            saveDailyLog(newLog)
        }
    }

    func saveDailyLog(_ log: DailyLog) {
        do {
            try db.collection("users").document(userId).collection("dailyLogs").document(log.id).setData(from: log)
        } catch {
            print("Error saving daily log: \(error)")
        }
    }
    
    func addHabit(name: String) {
        let newHabit = Habit(id: UUID().uuidString, name: name, isSelected: true)
        habits.append(newHabit)
        
        // Save the habit to Firestore
        do {
            try db.collection("users").document(userId).collection("habits").document(newHabit.id).setData(from: newHabit)
        } catch {
            print("Error saving habit: \(error)")
        }
    }
    
    func deleteHabit(at offsets: IndexSet) {
        for index in offsets {
            let habit = habits[index]
            
            // Remove the habit from Firestore
            db.collection("users").document(userId).collection("habits").document(habit.id).delete { error in
                if let error = error {
                    print("Error deleting habit: \(error)")
                }
            }
            
            // Remove the habit from the local array
            habits.remove(at: index)
        }
    }

}
