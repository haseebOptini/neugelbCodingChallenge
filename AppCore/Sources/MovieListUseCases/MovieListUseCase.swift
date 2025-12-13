import Foundation
import MovieListRepository
import NetworkManager

public struct MovieListUseCase: MovieListUseCaseProtocol {
    // MARK: - Private properties
    private let movieListRepository: MovieListRepositoryProtocol
    private let pageManager: PageManagerActorProtocol

    // MARK: - Init
    public init(movieListRepository: MovieListRepositoryProtocol, pageManager: PageManagerActorProtocol) {
        self.movieListRepository = movieListRepository
        self.pageManager = pageManager
    }

    // MARK: - MovieListUseCaseProtocol
    public func fetchNowPlayingMovies() async throws -> [Movie] {
        // Reset to page 1 for initial fetch
        await pageManager.reset()
        let page = await pageManager.getCurrentPage()
        let moviesDto = try await movieListRepository.fetchNowPlayingMovies(page: page)
        await pageManager.incrementPage()
        return map(moviesDto: moviesDto.movies)
    }
    
    public func loadMoreMovies() async throws -> [Movie] {
        let page = await pageManager.getNextPage()
        let moviesDto = try await movieListRepository.fetchNowPlayingMovies(page: page)
        await pageManager.incrementPage()
        return map(moviesDto: moviesDto.movies)
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
