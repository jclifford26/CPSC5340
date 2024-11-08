//
//  ExerciseListView.swift
//  FinalProject
//
//  Created by James Clifford on 11/8/24.
//

import SwiftUI

struct ExerciseListView: View {
    @StateObject private var viewModel = ExerciseViewModel()
    @State private var muscle: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter muscle group", text: $muscle)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Search") {
                viewModel.fetchExercises(for: muscle)
            }
            .padding()
            
            if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            }
            
            List(viewModel.exercises) { exercise in
                VStack(alignment: .leading) {
                    Text("Name: \(exercise.name)")
                        .font(.headline)
                    Text("Category: \(exercise.category)")
                    Text("Equipment: \(exercise.equipment)")
                    Text("Force: \(exercise.force)")
                    Text("Level: \(exercise.level)")
                    Text("Mechanic: \(exercise.mechanic)")
                    
                    // Display images if any
                    if !exercise.images.isEmpty {
                        ForEach(exercise.images, id: \.self) { image in
                            Text("Image: \(image)") // This can later be an image view
                        }
                    }
                    
                    Text("Instructions: \(exercise.instructions)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("Primary Muscles: \(exercise.primaryMuscles.joined(separator: ", "))")
                    Text("Secondary Muscles: \(exercise.secondaryMuscles.joined(separator: ", "))")
                }
                .padding(.vertical, 4)
            }
        }
        .padding()
        .onAppear {
            print("ExerciseListView Appeared")
        }
    }
}

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView()
    }
}
