import SwiftUI

struct ReleaseDateView: View {
    let releaseDate: String
    
    var body: some View {
        InfoSection(title: "Release Date") {
            Text(MovieDateFormatter.format(releaseDate))
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

