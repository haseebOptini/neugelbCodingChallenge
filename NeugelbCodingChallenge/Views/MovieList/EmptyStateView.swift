import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Text("No movies available")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 60)
        .padding()
    }
}

