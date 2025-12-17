import SwiftUI

struct GenresView: View {
    let genres: [GenreDisplayModel]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Genres")
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(genres, id: \.id) { genre in
                        GenreChip(name: genre.name)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct GenreChip: View {
    let name: String
    
    var body: some View {
        Text(name)
            .font(.caption)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.blue.opacity(0.2))
            .foregroundColor(.blue)
            .cornerRadius(12)
    }
}

