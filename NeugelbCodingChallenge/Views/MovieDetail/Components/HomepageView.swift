import SwiftUI

struct HomepageView: View {
    let url: String
    
    var body: some View {
        InfoSection(title: "Homepage") {
            if let url = URL(string: url) {
                Link("Visit Website", destination: url)
                    .font(.body)
            }
        }
    }
}

