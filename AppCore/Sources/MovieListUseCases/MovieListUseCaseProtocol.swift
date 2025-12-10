public protocol MovieListUseCaseProtocol {
    func fetchNowPlayingMovies() async throws -> [Movie]
}
