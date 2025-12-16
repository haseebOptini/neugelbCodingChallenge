public protocol MovieListUseCaseProtocol {
    func fetchMovies(resetPagination: Bool) async throws -> [Movie]
}
