import Foundation
import MovieListRepository
import NetworkManager

public struct MovieListUseCase: MovieListUseCaseProtocol {
    // MARK: - Private properties
    private let movieListRepository: MovieListRepositoryProtocol

    // MARK: - Init
    public init(movieListRepository: MovieListRepositoryProtocol) {
        self.movieListRepository = movieListRepository
    }

    // MARK: - MovieListUseCaseProtocol
    public func fetchNowPlayingMovies() async throws -> [Movie] {
        let moviesDto = try await movieListRepository.fetchNowPlayingMovies()
        return map(moviesDto: moviesDto.movies)
    }
    public func loadMoreMovies() async throws -> [Movie] {
        return []
    }
    
    private func map(moviesDto: [MovieDTO]) -> [Movie] {
        moviesDto.map { moviesDto in
            Movie(id: moviesDto.id,
                  title: moviesDto.title,
                  originalTitle: moviesDto.originalTitle,
                  originalLanguage: moviesDto.originalLanguage,
                  overview: moviesDto.overview,
                  releaseDate: moviesDto.releaseDate,
                  posterPath: moviesDto.posterPath,
                  voteAverage: moviesDto.voteAverage,
                  voteCount: moviesDto.voteCount,
                  adult: moviesDto.adult,
                  genreIds: moviesDto.genreIds)
        }
    }

}
