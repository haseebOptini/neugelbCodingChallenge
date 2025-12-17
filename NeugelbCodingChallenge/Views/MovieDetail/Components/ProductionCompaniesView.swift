import SwiftUI

struct ProductionCompaniesView: View {
    let companies: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Production Companies")
                .font(.headline)
            VStack(alignment: .leading, spacing: 4) {
                ForEach(companies, id: \.self) { company in
                    Text(company)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal)
    }
}

