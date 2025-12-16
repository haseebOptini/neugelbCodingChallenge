import SwiftUI
import MovieListUseCases

struct MovieView: View {
    private let movieViewModel: MovieViewModel

    init(movieViewModel: MovieViewModel) {
        self.movieViewModel = movieViewModel
    }

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ImageView(imageURL: movieViewModel.imageURL)
                .frame(width: 45, height: 45)
                .clipped()
                .cornerRadius(4)
                .background(Color.gray.opacity(0.1))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(movieViewModel.title.isEmpty ? "Untitled" : movieViewModel.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(movieViewModel.subtitle.isEmpty ? "No description available" : movieViewModel.subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(minHeight: 45)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 4)
        .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
        .background(Color.white)
    }
}

