public protocol SearchMoviesUseCaseProtocol {
    func searchMovies(query: String, resetPagination: Bool) async throws -> [Movie]
}

