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

    public func fetchMovieDetails(id: Int) async throws -> MovieDetailsDTO {
        let endPoint = MoviesDetailsEndPoint(movieId: id)
        return try await networkManager.request(endPoint, type: MovieDetailsDTO.self)
    }
    
    public func searchMovies(query: String, page: Int = 1) async throws -> MoviesDTO {
        let endPoint = SearchMoviesEndPoint(query: query, page: page)
        return try await networkManager.request(endPoint, type: MoviesDTO.self)
    }
}
