import SwiftUI

struct MovieHeaderView: View {
    let title: String
    let tagline: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            if let tagline = tagline, !tagline.isEmpty {
                Text(tagline)
                    .font(.title3)
                    .foregroundColor(.secondary)
                    .italic()
            }
        }
        .padding(.horizontal)
    }
}

