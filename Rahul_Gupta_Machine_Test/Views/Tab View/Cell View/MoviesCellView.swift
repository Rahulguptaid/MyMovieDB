//
//  MoviesCellView.swift
//  Rahul_Gupta_Machine_Test
//
//  Created by Rahul Gupta on 23/03/22.
//

import SwiftUI
struct MoviesCellView: View {
    var movieData : MovieModel?
    init(movie:MovieModel?) {
        // Intitaliinsing Cell form the Movie data
        movieData = movie
    }
    var body: some View {
        HStack(alignment: .center, spacing: 20, content: {
            // To show image on the cell by downloading from the URL. this code is handled this feature
            AsyncImage(url:  URL(string: movieData?.imageURL ?? "https://via.placeholder.com/200x200.jpg")!,
                       placeholder: { Image("SampleImage") }, image: { Image(uiImage: $0).resizable() }).frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(8)
            VStack(alignment:.leading,spacing: 10) {
                Text(movieData?.title ?? "title")
                    .font(.headline)
                // Already created computed properies in the Model class for the release date formatting
                Text(movieData?.formatedReleaseDate ?? "may 01, 2022")
                    .font(.subheadline)
            }
            Spacer()
        })
    }
}

struct MoviesCellView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesCellView(movie: nil)
    }
}
