import MovieListUseCases

@MainActor
struct ViewModelFactory {
    static func makeMoviesListViewModel() -> MoviesListViewModel {
        MoviesListViewModel(movieListUseCase: DIContainer.shared.movieListUseCases())
    }
    
    static func makeMovieDetailsViewModel(movie: Movie) -> MovieDetailsViewModel {
        MovieDetailsViewModel(
            movie: movie,
            movieDetailsUseCase: DIContainer.shared.movieDetailsUseCase()
        )
    }
    
    static func makeSearchViewModel() -> SearchViewModel {
        SearchViewModel(searchMoviesUseCase: DIContainer.shared.searchMoviesUseCase())
    }
}

