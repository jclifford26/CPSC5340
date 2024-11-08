//
//  ExerciseService.swift
//  FinalProject
//
//  Created by James Clifford on 11/8/24.
//

import Foundation

class ExerciseService {
    func fetchExercises(for muscle: String, completion: @escaping (Result<[Exercise], Error>) -> Void) {
        let headers = [
            "x-rapidapi-key": "e956c23e7fmsh75c16846d61d275p137d04jsnfae74a554bdf",
            "x-rapidapi-host": "exercise-db-fitness-workout-gym.p.rapidapi.com"
        ]
        
        guard let url = URL(string: "https://exercise-db-fitness-workout-gym.p.rapidapi.com/exercises/muscle/\(muscle)") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Server returned an error"])))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            // Debugging: Log the raw data for inspection
            if let rawJSON = String(data: data, encoding: .utf8) {
                print("Received JSON: \(rawJSON)") // Inspect the raw JSON response
            }
            
            // Decode the JSON response into Exercise objects
            do {
                let exercises = try JSONDecoder().decode([Exercise].self, from: data)
                print("Decoded Exercises: \(exercises)") // Debugging: Print the decoded exercises
                completion(.success(exercises))
            } catch {
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
}
