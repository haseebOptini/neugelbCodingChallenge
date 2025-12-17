import Foundation
import MovieListUseCases

enum MovieDetailsViewState: Equatable {
    case initial
    case loading
    case loaded(MovieDetailsDisplayModel)
    case error
}

@MainActor
final class MovieDetailsViewModel: ObservableObject {
    // MARK: - Published properties
    @Published var state: MovieDetailsViewState = .initial
    
    // MARK: - Private properties
    private let movie: Movie
    private let movieDetailsUseCase: MovieDetailsUseCaseProtocol
    private let currencyFormatter: CurrencyFormatterProtocol
    private let runtimeFormatter: RuntimeFormatterProtocol
    private let dateFormatter: DateFormatterProtocol

    // MARK: - Init
    init(
        movie: Movie,
        movieDetailsUseCase: MovieDetailsUseCaseProtocol,
        currencyFormatter: CurrencyFormatterProtocol,
        runtimeFormatter: RuntimeFormatterProtocol,
        dateFormatter: DateFormatterProtocol
    ) {
        self.movie = movie
        self.movieDetailsUseCase = movieDetailsUseCase
        self.currencyFormatter = currencyFormatter
        self.runtimeFormatter = runtimeFormatter
        self.dateFormatter = dateFormatter
    }

    // MARK: - Public Methods
    func fetchMovieDetails() async {
        state = .loading
        
        do {
            let details = try await movieDetailsUseCase.fetchMovieDetails(id: movie.id)
            let displayModel = mapToDisplayModel(details)
            state = .loaded(displayModel)
        } catch {
            print("alog::MovieDetailsViewModel::fetchMovieDetails::error: \(error)")
            state = .error
        }
    }
    
    // MARK: - Private Methods
    private func mapToDisplayModel(_ details: MovieDetails) -> MovieDetailsDisplayModel {
        return MovieDetailsDisplayModel(
            posterURL: details.posterPath,
            title: details.title,
            tagline: details.tagline,
            overview: details.overview,
            genres: mapGenres(details.genres),
            releaseDate: formatReleaseDate(details.releaseDate),
            runtime: formatRuntime(details.runtime),
            rating: formatRating(details.voteAverage),
            voteCount: formatVoteCount(details.voteCount),
            productionCompanies: mapProductionCompanies(details.productionCompanies),
            productionCountries: mapProductionCountries(details.productionCountries),
            spokenLanguages: mapSpokenLanguages(details.spokenLanguages),
            budget: formatBudget(details.budget),
            revenue: formatRevenue(details.revenue)
        )
    }
    
    private func mapGenres(_ genres: [Genre]?) -> [GenreDisplayModel] {
        guard let genres = genres else { return [] }
        return genres.map { GenreDisplayModel(id: $0.id, name: $0.name) }
    }
    
    private func formatReleaseDate(_ date: String?) -> String? {
        guard let date = date, !date.isEmpty else { return nil }
        return dateFormatter.format(date)
    }
    
    private func formatRuntime(_ runtime: Int?) -> String? {
        guard let runtime = runtime else { return nil }
        return runtimeFormatter.format(runtime)
    }
    
    private func formatRating(_ rating: Double?) -> String? {
        guard let rating = rating else { return nil }
        return String(format: "%.1f", rating)
    }
    
    private func formatVoteCount(_ count: Int?) -> String? {
        guard let count = count else { return nil }
        return "(\(count) votes)"
    }
    
    private func mapProductionCompanies(_ companies: [ProductionCompany]?) -> [String] {
        guard let companies = companies else { return [] }
        return companies.map { $0.name }
    }
    
    private func mapProductionCountries(_ countries: [ProductionCountry]?) -> [String] {
        guard let countries = countries else { return [] }
        return countries.map { $0.name }
    }
    
    private func mapSpokenLanguages(_ languages: [SpokenLanguage]?) -> [String] {
        guard let languages = languages else { return [] }
        return languages.compactMap { $0.name ?? $0.englishName }
    }
    
    private func formatBudget(_ budget: Int?) -> String? {
        guard let budget = budget, budget > 0 else { return nil }
        return currencyFormatter.format(budget)
    }
    
    private func formatRevenue(_ revenue: Int?) -> String? {
        guard let revenue = revenue, revenue > 0 else { return nil }
        return currencyFormatter.format(revenue)
    }
}
