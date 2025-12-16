import SwiftUI

struct MoviePosterView: View {
    let posterURL: String?
    
    var body: some View {
        if let posterURL = posterURL {
            ImageView(imageURL: posterURL)
                .frame(height: 400)
                .clipped()
                .cornerRadius(8)
        }
    }
}

