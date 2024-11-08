//
//  Untitled.swift
//  FinalProject
//
//  Created by James Clifford on 11/8/24.
//

import Foundation
import Combine

class ExerciseViewModel: ObservableObject {
    @Published var exercises: [Exercise] = []
    @Published var errorMessage: String?
    private var service = ExerciseService()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchExercises(for muscle: String) {
        service.fetchExercises(for: muscle) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let exercises):
                    self?.exercises = exercises
                    self?.errorMessage = nil  // Clear any previous error
                    print("Fetched Exercises: \(exercises)") // Debugging: Verify fetched data
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Error: \(error.localizedDescription)") // Debugging: Print error
                }
            }
        }
    }
}
