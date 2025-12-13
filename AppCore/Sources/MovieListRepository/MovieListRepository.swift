import Foundation
import NetworkManager

public struct MovieListRepository: MovieListRepositoryProtocol {
    private let networkManager: NetworkManagerProtocol
    
    public init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    public func fetchNowPlayingMovies(page: Int = 1) async throws -> MoviesDTO {
        let endPoint = NowPlayingMoviesEndPoint(page: page)
        return try await networkManager.request(endPoint, type: MoviesDTO.self)
    }
}
