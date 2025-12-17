import Foundation
import MovieListRepository
import MovieListUseCases

// MARK: - Single Mock Repository for All Use Cases
final class RepositoryMock: MovieListRepositoryProtocol {
    // MARK: - Properties for Movie List
    var fetchNowPlayingMoviesCallCount = 0
    var fetchNowPlayingMoviesPage: Int?
    
    // MARK: - Properties for Movie Details
    var fetchMovieDetailsCallCount = 0
    var fetchMovieDetailsId: Int?
    
    // MARK: - Properties for Search
    var searchMoviesCallCount = 0
    var searchMoviesQuery: String?
    var searchMoviesPage: Int?
    
    // MARK: - Configuration
    private var shouldThrowError = false
    private var errorToThrow: Error?
    private var moviesDTOToReturn: MoviesDTO?
    private var movieDetailsDTOToReturn: MovieDetailsDTO?
    
    func configure(
        shouldThrowError: Bool = false,
        errorToThrow: Error? = nil,
        moviesDTOToReturn: MoviesDTO? = nil,
        movieDetailsDTOToReturn: MovieDetailsDTO? = nil
    ) {
        self.shouldThrowError = shouldThrowError
        self.errorToThrow = errorToThrow
        self.moviesDTOToReturn = moviesDTOToReturn
        self.movieDetailsDTOToReturn = movieDetailsDTOToReturn
    }
    
    // MARK: - MovieListRepositoryProtocol
    
    func fetchNowPlayingMovies(page: Int) async throws -> MoviesDTO {
        fetchNowPlayingMoviesCallCount += 1
        fetchNowPlayingMoviesPage = page
        
        if shouldThrowError {
            throw errorToThrow ?? NSError(domain: "TestError", code: 1)
        }
        
        return moviesDTOToReturn ?? .mock(page: page)
    }
    
    func fetchMovieDetails(id: Int) async throws -> MovieDetailsDTO {
        fetchMovieDetailsCallCount += 1
        fetchMovieDetailsId = id
        
        if shouldThrowError {
            throw errorToThrow ?? NSError(domain: "TestError", code: 1)
        }
        
        return movieDetailsDTOToReturn ?? .mock(id: id)
    }
    
    func searchMovies(query: String, page: Int) async throws -> MoviesDTO {
        searchMoviesCallCount += 1
        searchMoviesQuery = query
        searchMoviesPage = page
        
        if shouldThrowError {
            throw errorToThrow ?? NSError(domain: "TestError", code: 1)
        }
        
        return moviesDTOToReturn ?? .mock(
            page: page,
            movies: [.mock()],
            totalPages: 3,
            totalResults: 30
        )
    }
}

