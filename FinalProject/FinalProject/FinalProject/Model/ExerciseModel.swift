//
//  ExerciseModel.swift
//  FinalProject
//
//  Created by James Clifford on 11/8/24.
//

import Foundation

// Exercise model for decoding JSON from API
struct Exercise: Identifiable, Decodable {
    let id : String  // Assuming id is a string, since it seems to be a unique exercise identifier
    let name: String
    let category: String
    let equipment: String
    let force: String
    let images: [String]  // Assuming images is an array of URLs or strings
    let instructions: String
    let level: String
    let mechanic: String
    let primaryMuscles: [String]
    let secondaryMuscles: [String]
    
    // Implement Identifiable using id
    //var id: String { self.id }
}
