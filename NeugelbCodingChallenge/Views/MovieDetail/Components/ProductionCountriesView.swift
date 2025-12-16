import SwiftUI
import MovieListUseCases

struct ProductionCountriesView: View {
    let countries: [ProductionCountry]
    
    var body: some View {
        InfoSection(title: "Production Countries") {
            ForEach(countries, id: \.iso31661) { country in
                Text(country.name)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
    }
}

