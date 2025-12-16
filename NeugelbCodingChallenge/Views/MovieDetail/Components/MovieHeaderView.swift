import SwiftUI
import MovieListUseCases

struct MovieHeaderView: View {
    let movieDetails: MovieDetails
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(movieDetails.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            if let tagline = movieDetails.tagline, !tagline.isEmpty {
                Text(tagline)
                    .font(.title3)
                    .foregroundColor(.secondary)
                    .italic()
            }
        }
        .padding(.horizontal)
    }
}

