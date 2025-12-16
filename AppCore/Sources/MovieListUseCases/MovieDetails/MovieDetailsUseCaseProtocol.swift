public protocol MovieDetailsUseCaseProtocol {
    func fetchMovieDetails(id: Int) async throws -> MovieDetails
}
