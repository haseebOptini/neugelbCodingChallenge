import SwiftUI

struct RuntimeView: View {
    let runtime: Int
    
    var body: some View {
        InfoSection(title: "Runtime") {
            Text(RuntimeFormatter.format(runtime))
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

