import SwiftUI
import MovieListUseCases

struct MovieDetailsView: View {
    @StateObject var viewModel: MovieDetailsViewModel
    
    init(viewModel: MovieDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content
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
            movieDetailsContent(movieDetailViewModel: movieDetailViewModel)
            
        case .error:
            ErrorView {
                await viewModel.fetchMovieDetails()
            }
        }
    }
    
    @ViewBuilder
    private func movieDetailsContent(movieDetailViewModel: MovieDetailViewModel) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Poster Image
                if let posterURL = movieDetailViewModel.movieDetails.posterPath {
                    ImageView(imageURL: posterURL)
                        .frame(height: 400)
                        .clipped()
                        .cornerRadius(8)
                }
                
                // Title and Tagline
                VStack(alignment: .leading, spacing: 8) {
                    Text(movieDetailViewModel.movieDetails.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    if let tagline = movieDetailViewModel.movieDetails.tagline, !tagline.isEmpty {
                        Text(tagline)
                            .font(.title3)
                            .foregroundColor(.secondary)
                            .italic()
                    }
                }
                .padding(.horizontal)
                
                // Overview
                if let overview = movieDetailViewModel.movieDetails.overview, !overview.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Overview")
                            .font(.headline)
                        Text(overview)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                }
                
                // Genres
                if let genres = movieDetailViewModel.movieDetails.genres, !genres.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Genres")
                            .font(.headline)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(genres, id: \.id) { genre in
                                    Text(genre.name)
                                        .font(.caption)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.blue.opacity(0.2))
                                        .foregroundColor(.blue)
                                        .cornerRadius(12)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Release Date
                if let releaseDate = movieDetailViewModel.movieDetails.releaseDate, !releaseDate.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Release Date")
                            .font(.headline)
                        Text(releaseDate)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                }
                
                // Runtime
                if let runtime = movieDetailViewModel.movieDetails.runtime {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Runtime")
                            .font(.headline)
                        Text("\(runtime) minutes")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                }
                
                // Rating
                if let voteAverage = movieDetailViewModel.movieDetails.voteAverage {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Rating")
                            .font(.headline)
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", voteAverage))
                                .font(.body)
                                .foregroundColor(.secondary)
                            if let voteCount = movieDetailViewModel.movieDetails.voteCount {
                                Text("(\(voteCount) votes)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Production Companies
                if let productionCompanies = movieDetailViewModel.movieDetails.productionCompanies, !productionCompanies.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Production Companies")
                            .font(.headline)
                        ForEach(productionCompanies, id: \.id) { company in
                            Text(company.name)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Budget and Revenue
                if let budget = movieDetailViewModel.movieDetails.budget, budget > 0 {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Budget")
                            .font(.headline)
                        Text(formatCurrency(budget))
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                }
                
                if let revenue = movieDetailViewModel.movieDetails.revenue, revenue > 0 {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Revenue")
                            .font(.headline)
                        Text(formatCurrency(revenue))
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .background(Color.white)
    }
    
    private func formatCurrency(_ amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: amount)) ?? "$\(amount)"
    }
}

