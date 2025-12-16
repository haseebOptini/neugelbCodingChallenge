import SwiftUI

struct ErrorView: View {
    let onRetry: () async -> Void
    
    init(onRetry: @escaping () async -> Void) {
        self.onRetry = onRetry
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundColor(.orange)
            
            Text("Unable to Load Movies")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("We encountered an error while fetching movies. Please check your connection and try again.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            
            Button(action: {
                Task {
                    await onRetry()
                }
            }) {
                Text("Retry")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: 200)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

