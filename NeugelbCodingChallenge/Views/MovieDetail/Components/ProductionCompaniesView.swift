import SwiftUI
import MovieListUseCases

struct ProductionCompaniesView: View {
    let companies: [ProductionCompany]
    
    var body: some View {
        InfoSection(title: "Production Companies") {
            ForEach(companies, id: \.id) { company in
                Text(company.name)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
    }
}

