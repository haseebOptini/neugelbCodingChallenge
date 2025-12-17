import Foundation
import Testing
import MovieListUseCases
import MovieListRepository
@testable import MovieListUseCases

// MARK: - Tests
struct MovieDetailsUseCaseTests {
    
    // Scenario 1: Repository returns valid response
    @Test("Fetch movie details should return movie details when repository returns valid response")
    func testFetchMovieDetailsWithValidResponse() async throws {
        // Given
        let repositoryMock = RepositoryMock()
        let sut = MovieDetailsUseCase(movieListRepository: repositoryMock)
        let movieId = 123
        
        // When
        let movieDetails = try await sut.fetchMovieDetails(id: movieId)
        
        // Then
        #expect(movieDetails.id == movieId)
        #expect(repositoryMock.fetchMovieDetailsCallCount == 1)
        #expect(repositoryMock.fetchMovieDetailsId == movieId)
    }
    
    // Scenario 2: Repository throws error
    @Test("Fetch movie details should propagate repository errors")
    func testFetchMovieDetailsPropagatesErrors() async throws {
        // Given
        let repositoryMock = RepositoryMock()
        let expectedError = NSError(domain: "NetworkError", code: 404)
        repositoryMock.configure(shouldThrowError: true, errorToThrow: expectedError)
        
        let sut = MovieDetailsUseCase(movieListRepository: repositoryMock)
        
        // When/Then
        await #expect(throws: NSError.self) {
            try await sut.fetchMovieDetails(id: 1)
        }
        
        #expect(repositoryMock.fetchMovieDetailsCallCount == 1)
    }
}
