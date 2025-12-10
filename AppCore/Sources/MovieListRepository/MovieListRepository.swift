import Foundation
import NetworkManager

public struct MovieListRepository: MovieListRepositoryProtocol {
    private let networkManager: NetworkManagerProtocol
    
    public init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    public func fetchNowPlayingMovies() async throws -> MoviesDTO {
        let endPoint = NowPlayingMoviesEndPoint()
        return try await networkManager.request(endPoint, type: MoviesDTO.self)
    }
}
