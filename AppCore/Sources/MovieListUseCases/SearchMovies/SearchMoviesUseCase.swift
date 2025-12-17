import Foundation
import MovieListRepository
import NetworkManager

public struct SearchMoviesUseCase: SearchMoviesUseCaseProtocol {
    // MARK: - Private properties
    private let movieListRepository: MovieListRepositoryProtocol
    private let pageManager: PageManagerProtocol
    
    // MARK: - Init
    public init(movieListRepository: MovieListRepositoryProtocol, pageManager: PageManagerProtocol) {
        self.movieListRepository = movieListRepository
        self.pageManager = pageManager
    }
    
    // MARK: - SearchMoviesUseCaseProtocol
    public func searchMovies(query: String, resetPagination: Bool = false) async throws -> [Movie] {
        if resetPagination {
            await pageManager.reset()
        }
        
        let hasMorePages = await pageManager.hasMorePages()
        guard hasMorePages else {
            print("alog::SearchMoviesUseCase::searchMovies - No more pages")
            return []
        }
        
        let page = await pageManager.getCurrentPage()
        let moviesDto = try await movieListRepository.searchMovies(query: query, page: page)
        
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

