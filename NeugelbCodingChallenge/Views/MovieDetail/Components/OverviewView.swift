import SwiftUI

struct OverviewView: View {
    let overview: String
    
    var body: some View {
        InfoSection(title: "Overview") {
            Text(overview)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

