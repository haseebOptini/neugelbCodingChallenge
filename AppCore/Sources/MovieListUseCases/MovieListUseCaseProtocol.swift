public protocol MovieListUseCaseProtocol {
    func fetchNowPlayingMovies() async throws -> [Movie]
    func loadMoreMovies() async throws -> [Movie]
}
