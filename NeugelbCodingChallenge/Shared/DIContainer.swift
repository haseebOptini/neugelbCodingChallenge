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
    
    func movieListUseCases() -> MovieListUseCaseProtocol {
        MovieListUseCase(movieListRepository: movieListRepository())
    }
}

// TODO: Need to create a separate file for this but for now creating this in the same file
struct MovieListViewModelFactory {
    @MainActor static func makeMoviesListViewModel() -> MoviesListViewModel {
        MoviesListViewModel(movieListUseCase: DIContainer.shared.movieListUseCases())
    }
}
