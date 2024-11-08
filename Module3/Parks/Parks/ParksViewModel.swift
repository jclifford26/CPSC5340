//
//  ParksViewModel.swift
//  Parks
//
//  Created by James Clifford on 10/28/24.
//

import Foundation

class ParksViewModel : ObservableObject {
    
    @Published private(set) var parksData = [ParkModel]()
    @Published var hasError = false
    @Published var error : ParkModelError?
    private let url = "https://developer.nps.gov/api/v1/parks?limit=20&api_key=g1EHJ9XRS19iBw4NdgLYVJOZw08l50RovalBy4ZG"
    
//    func fetchData() {
//        if let url = URL(string: self.url) {
//
//            URLSession
//                .shared
//                .dataTask(with: url) { (data, response, error) in
//                    if let error = error {
//                        print(error)
//                    } else {
//                        if let data = data {
//                            do {
//                                let results = try JSONDecoder().decode(ParkResults.self, from: data)
//                                DispatchQueue.main.async {
//                                    self.parksData = results.data
//                                }
//
//                            } catch {
//                                print(error)
//                            }
//                        }
//                    }
//                }.resume()
//        }
//
//    }
    
    @MainActor
    func fetchData() async {
        if let url = URL(string: url) {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let results = try JSONDecoder().decode(ParkResults?.self, from: data) else {
                    self.hasError.toggle()
                    self.error = ParkModelError.decodeError
                    return
                }
                self.parksData = results.data
            } catch {
                self.hasError.toggle()
                self.error = ParkModelError.customError(error: error)
            }
        }
    }
    
}

extension ParksViewModel {
    enum ParkModelError : LocalizedError {
        case decodeError
        case customError(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .decodeError:
                return "Decoding Error"
            case .customError(let error):
                return error.localizedDescription
            }
        }
        
    }

}
