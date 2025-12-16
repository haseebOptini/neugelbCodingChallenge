import SwiftUI

struct ImageView: View {
    let imageURL: String
    
    var body: some View {
        if let url = URL(string: imageURL), !imageURL.isEmpty {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                    
                case .failure:
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                @unknown default:
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        } else {
            Image(systemName: "photo")
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

