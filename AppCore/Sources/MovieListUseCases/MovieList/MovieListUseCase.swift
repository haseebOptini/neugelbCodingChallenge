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
    public func fetchMovies(resetPagination: Bool = false) async throws -> [Movie] {
        let hasMorePages = await pageManager.hasMorePages()
        guard hasMorePages else {
            return []
        }

        if resetPagination {
            await pageManager.reset()
        }

        let page = await pageManager.getNextPage()
        let moviesDto = try await movieListRepository.fetchNowPlayingMovies(page: page)

        await pageManager.setTotalPages(moviesDto.totalPages)
        await pageManager.incrementPage()
        return map(moviesDto: moviesDto.movies)
    }

    // MARK: - Private methods
    private func map(moviesDto: [MovieDTO]) -> [Movie] {
        moviesDto.map { dto in
            let posterURL: String?
            if let posterPath = dto.posterPath {
                posterURL = ImageBaseURL.tmdb.rawValue + posterPath
            } else {
                posterURL = nil
            }
            
            return Movie(id: dto.id,
                         title: dto.title,
                         originalTitle: dto.originalTitle,
                         originalLanguage: dto.originalLanguage,
                         overview: dto.overview,
                         releaseDate: dto.releaseDate,
                         posterPath: posterURL,
                         voteAverage: dto.voteAverage,
                         voteCount: dto.voteCount,
                         adult: dto.adult,
                         backdropPath: dto.backdropPath,
                         genreIds: dto.genreIds)
        }
    }

}
