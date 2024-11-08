//
//  ImageCardView.swift
//  Parks
//
//  Created by James Clifford on 10/27/24.
//

import SwiftUI

struct ImageCardView: View {
    
    var url : String
    
    var body : some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
                .scaledToFit()
                .cornerRadius(10)
        } placeholder: {
            ProgressView()
        }
        .frame(width: 50, height: 50)
    }
}

struct ImageCardView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCardView(url: "https://www.nps.gov/common/uploads/structured_data/3C861078-1DD8-B71B-0B774A242EF6A706.jpg")
    }
}
