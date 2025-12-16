import SwiftUI

struct RatingView: View {
    let voteAverage: Double
    let voteCount: Int?
    
    var body: some View {
        InfoSection(title: "Rating") {
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text(String(format: "%.1f", voteAverage))
                    .font(.body)
                    .foregroundColor(.secondary)
                if let voteCount = voteCount {
                    Text("(\(voteCount) votes)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

