//
//  MapView.swift
//  Parks
//
//  Created by James Clifford on 10/27/24.
//

import SwiftUI
import MapKit

struct MapView: View {
   
    var coordinate : CLLocationCoordinate2D
    
    var body: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: coordinate, latitudinalMeters: 750, longitudinalMeters: 750)))
    }
}

