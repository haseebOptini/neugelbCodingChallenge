import SwiftUI
import MovieListUseCases

struct GenresView: View {
    let genres: [Genre]
    
    var body: some View {
        InfoSection(title: "Genres") {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(genres, id: \.id) { genre in
                        GenreChip(genre: genre)
                    }
                }
            }
        }
    }
}

struct GenreChip: View {
    let genre: Genre
    
    var body: some View {
        Text(genre.name)
            .font(.caption)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.blue.opacity(0.2))
            .foregroundColor(.blue)
            .cornerRadius(12)
    }
}

