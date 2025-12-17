import SwiftUI

struct RatingView: View {
    let rating: String
    let voteCount: String?
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            Text(rating)
                .font(.body)
                .foregroundColor(.secondary)
            if let voteCount = voteCount {
                Text(voteCount)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

