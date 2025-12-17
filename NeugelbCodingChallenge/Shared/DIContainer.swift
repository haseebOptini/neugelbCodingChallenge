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
    
    func pageManager() -> PageManagerProtocol {
        PageManagerActor()
    }
    
    func movieListUseCases() -> MovieListUseCaseProtocol {
        MovieListUseCase(movieListRepository: movieListRepository(), pageManager: pageManager())
    }
    
    func movieDetailsUseCase() -> MovieDetailsUseCaseProtocol {
        MovieDetailsUseCase(movieListRepository: movieListRepository())
    }
    
    func searchMoviesUseCase() -> SearchMoviesUseCaseProtocol {
        SearchMoviesUseCase(movieListRepository: movieListRepository(), pageManager: pageManager())
    }
    
    // MARK: - Formatters
    func currencyFormatter() -> CurrencyFormatterProtocol {
        CurrencyFormatter()
    }
    
    func runtimeFormatter() -> RuntimeFormatterProtocol {
        RuntimeFormatter()
    }
    
    func dateFormatter() -> DateFormatterProtocol {
        MovieDateFormatter()
    }
}
