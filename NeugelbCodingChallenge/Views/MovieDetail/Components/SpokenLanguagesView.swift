import SwiftUI

struct SpokenLanguagesView: View {
    let languages: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Spoken Languages")
                .font(.headline)
            VStack(alignment: .leading, spacing: 4) {
                ForEach(languages, id: \.self) { language in
                    Text(language)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal)
    }
}

