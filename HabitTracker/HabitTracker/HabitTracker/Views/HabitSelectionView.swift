//
//  HabitSelectionView.swift
//  HabitTracker
//
//  Created by James Clifford on 11/11/24.
//

import SwiftUI
import FirebaseAuth

struct HabitSelectionView: View {
    @ObservedObject var viewModel: HabitTrackerViewModel
    @State private var isShowingAddHabit = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.habits, id: \.id) { habit in
                        HStack {
                            Text(habit.name)
                            Spacer()
                            if habit.isSelected {
                                Image(systemName: "checkmark")
                            }
                        }
                        .onTapGesture {
                            if let index = viewModel.habits.firstIndex(where: { $0.id == habit.id }) {
                                viewModel.habits[index].isSelected.toggle()
                                viewModel.saveHabit(viewModel.habits[index])
                                
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteHabit) // Enable swipe-to-delete
                }
                .listStyle(InsetGroupedListStyle())
                .onAppear {
                    viewModel.loadHabits()
                }
                // Logout Button
                Button(action: {
                    logout()
                }) {
                    Text("Log Out")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [.green, .blue]),
                                    startPoint: .top,
                                    endPoint: .bottomTrailing
                                ))
                        )
                        .foregroundColor(.white)
                }
                .padding()
            }
            .navigationTitle("Habits")
            .navigationBarItems(trailing: Button(action: {
                isShowingAddHabit = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isShowingAddHabit) {
                AddHabitView(viewModel: viewModel)
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            // Dismiss the current view to show the login screen
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
