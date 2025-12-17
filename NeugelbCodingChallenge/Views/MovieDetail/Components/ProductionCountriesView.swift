import SwiftUI

struct ProductionCountriesView: View {
    let countries: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Production Countries")
                .font(.headline)
            VStack(alignment: .leading, spacing: 4) {
                ForEach(countries, id: \.self) { country in
                    Text(country)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal)
    }
}

