public protocol MovieListRepositoryProtocol {
    func fetchNowPlayingMovies(page: Int) async throws -> MoviesDTO
    func fetchMovieDetails(id: Int) async throws -> MovieDetailsDTO
}
