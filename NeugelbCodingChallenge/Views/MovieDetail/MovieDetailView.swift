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
            
        case .loaded(let movieDetailViewModel):
            movieDetailsContent(movieDetails: movieDetailViewModel.movieDetails)
            
        case .error:
            ErrorView {
                await viewModel.fetchMovieDetails()
            }
        }
    }
    
    @ViewBuilder
    private func movieDetailsContent(movieDetails: MovieDetails) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                MoviePosterView(posterURL: movieDetails.posterPath)
                MovieHeaderView(movieDetails: movieDetails)
                
                if let overview = movieDetails.overview, !overview.isEmpty {
                    OverviewView(overview: overview)
                }
                
                if let genres = movieDetails.genres, !genres.isEmpty {
                    GenresView(genres: genres)
                }
                
                metadataSection(movieDetails: movieDetails)
                
                if let companies = movieDetails.productionCompanies, !companies.isEmpty {
                    ProductionCompaniesView(companies: companies)
                }
                
                if let countries = movieDetails.productionCountries, !countries.isEmpty {
                    ProductionCountriesView(countries: countries)
                }
                
                if let languages = movieDetails.spokenLanguages, !languages.isEmpty {
                    SpokenLanguagesView(languages: languages)
                }
                
                financialInfoSection(movieDetails: movieDetails)
                
                if let homepage = movieDetails.homepage, !homepage.isEmpty {
                    HomepageView(url: homepage)
                }
            }
            .padding(.vertical)
        }
        .background(Color.white)
    }
    
    @ViewBuilder
    private func metadataSection(movieDetails: MovieDetails) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            if let releaseDate = movieDetails.releaseDate, !releaseDate.isEmpty {
                ReleaseDateView(releaseDate: releaseDate)
            }
            
            if let runtime = movieDetails.runtime {
                RuntimeView(runtime: runtime)
            }
            
            if let voteAverage = movieDetails.voteAverage {
                RatingView(voteAverage: voteAverage, voteCount: movieDetails.voteCount)
            }
        }
    }
    
    @ViewBuilder
    private func financialInfoSection(movieDetails: MovieDetails) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            if let budget = movieDetails.budget, budget > 0 {
                InfoSection(title: "Budget") {
                    Text(CurrencyFormatter.format(budget))
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            
            if let revenue = movieDetails.revenue, revenue > 0 {
                InfoSection(title: "Revenue") {
                    Text(CurrencyFormatter.format(revenue))
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

