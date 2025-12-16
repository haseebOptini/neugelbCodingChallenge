import Foundation
import MovieListUseCases

enum MovieDetailsViewState: Equatable {
    case initial
    case loading
    case loaded(MovieDetailViewModel)
    case error
}

@MainActor
final class MovieDetailsViewModel: ObservableObject {
    // MARK: - Published properties
    @Published var state: MovieDetailsViewState = .initial
    
    // MARK: - Private properties
    private let movie: Movie
    private let movieDetailsUseCase: MovieDetailsUseCaseProtocol

    // MARK: - Init
    init(movie: Movie,
        movieDetailsUseCase: MovieDetailsUseCaseProtocol) {
        self.movie = movie
        self.movieDetailsUseCase = movieDetailsUseCase
    }

    // MARK: - Public Methods
    func fetchMovieDetails() async {
        state = .loading
        
        do {
            let details = try await movieDetailsUseCase.fetchMovieDetails(id: movie.id)
            let movieDetailViewModel = MovieDetailViewModel(movieDetails: details)
            state = .loaded(movieDetailViewModel)
        } catch {
            print("alog::MovieDetailsViewModel::fetchMovieDetails::error: \(error)")
            state = .error
        }
    }
}
