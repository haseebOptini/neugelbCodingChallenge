public protocol MovieListRepositoryProtocol {
    func fetchNowPlayingMovies() async throws -> MoviesDTO
}
