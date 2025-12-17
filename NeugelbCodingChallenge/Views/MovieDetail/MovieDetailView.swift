import SwiftUI
import MovieListUseCases

struct MovieDetailsView: View {
    @StateObject var viewModel: MovieDetailsViewModel
    
    init(viewModel: MovieDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.fetchMovieDetails()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading, .initial:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        case .loaded(let displayModel):
            movieDetailsContent(displayModel: displayModel)
            
        case .error:
            ErrorView {
                await viewModel.fetchMovieDetails()
            }
        }
    }
    
    @ViewBuilder
    private func movieDetailsContent(displayModel: MovieDetailsDisplayModel) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                moviePoster(posterURL: displayModel.posterURL)
                MovieHeaderView(title: displayModel.title, tagline: displayModel.tagline)
                
                if let overview = displayModel.overview, !overview.isEmpty {
                    overviewSection(overview: overview)
                }
                
                if !displayModel.genres.isEmpty {
                    GenresView(genres: displayModel.genres)
                }
                
                metadataSection(displayModel: displayModel)
                
                if !displayModel.productionCompanies.isEmpty {
                    ProductionCompaniesView(companies: displayModel.productionCompanies)
                }
                
                if !displayModel.productionCountries.isEmpty {
                    ProductionCountriesView(countries: displayModel.productionCountries)
                }
                
                if !displayModel.spokenLanguages.isEmpty {
                    SpokenLanguagesView(languages: displayModel.spokenLanguages)
                }
                
                financialInfoSection(displayModel: displayModel)
            }
            .padding(.vertical)
        }
        .background(Color.white)
    }
    
    @ViewBuilder
    private func metadataSection(displayModel: MovieDetailsDisplayModel) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            if let releaseDate = displayModel.releaseDate {
                releaseDateSection(releaseDate: releaseDate)
            }
            
            if let runtime = displayModel.runtime {
                runtimeSection(runtime: runtime)
            }
            
            if let rating = displayModel.rating {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Rating")
                        .font(.headline)
                    RatingView(rating: rating, voteCount: displayModel.voteCount)
                }
                .padding(.horizontal)
            }
        }
    }
    
    @ViewBuilder
    private func overviewSection(overview: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Overview")
                .font(.headline)
            Text(overview)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func releaseDateSection(releaseDate: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Release Date")
                .font(.headline)
            Text(releaseDate)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func runtimeSection(runtime: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Runtime")
                .font(.headline)
            Text(runtime)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func moviePoster(posterURL: String?) -> some View {
        if let posterURL = posterURL {
            ImageView(imageURL: posterURL)
                .frame(height: 400)
                .clipped()
                .cornerRadius(8)
        }
    }
    
    @ViewBuilder
    private func financialInfoSection(displayModel: MovieDetailsDisplayModel) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            if let budget = displayModel.budget {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Budget")
                        .font(.headline)
                    Text(budget)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
            }
            
            if let revenue = displayModel.revenue {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Revenue")
                        .font(.headline)
                    Text(revenue)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
            }
        }
    }
}

