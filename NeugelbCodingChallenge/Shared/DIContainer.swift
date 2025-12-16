import NetworkManager
import MovieListRepository
import MovieListUseCases

struct DIContainer {
    static let shared = DIContainer()
    
    private init() {}
    
    func networkManager() -> NetworkManagerProtocol {
        NetworkClient()
    }
    
    func movieListRepository() -> MovieListRepositoryProtocol {
        MovieListRepository(networkManager: networkManager())
    }
    
    func pageManager() -> PageManagerActorProtocol {
        PageManagerActor()
    }
    
    func movieListUseCases() -> MovieListUseCaseProtocol {
        MovieListUseCase(movieListRepository: movieListRepository(), pageManager: pageManager())
    }
    
    func movieDetailsUseCase() -> MovieDetailsUseCaseProtocol {
        MovieDetailsUseCase(movieListRepository: movieListRepository())
    }
}

// TODO: Need to create a separate file for this but for now creating this in the same file
@MainActor
struct MovieListViewModelFactory {
    static func makeMoviesListViewModel() -> MoviesListViewModel {
        MoviesListViewModel(movieListUseCase: DIContainer.shared.movieListUseCases())
    }
    
    static func makeMovieDetailsViewModel(movie: Movie) -> MovieDetailsViewModel {
        MovieDetailsViewModel(
            movie: movie,
            movieDetailsUseCase: DIContainer.shared.movieDetailsUseCase()
        )
    }
}
