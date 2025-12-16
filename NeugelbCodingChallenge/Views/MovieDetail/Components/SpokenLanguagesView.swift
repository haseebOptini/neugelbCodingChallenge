import SwiftUI
import MovieListUseCases

struct SpokenLanguagesView: View {
    let languages: [SpokenLanguage]
    
    var body: some View {
        InfoSection(title: "Spoken Languages") {
            ForEach(Array(languages.enumerated()), id: \.offset) { _, language in
                Text(language.name ?? language.englishName ?? "")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
    }
}

