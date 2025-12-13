public protocol MovieListRepositoryProtocol {
    func fetchNowPlayingMovies(page: Int) async throws -> MoviesDTO
}
