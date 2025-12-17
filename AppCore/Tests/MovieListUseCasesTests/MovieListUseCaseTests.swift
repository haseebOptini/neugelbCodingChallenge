import Foundation
import Testing
import MovieListUseCases
import MovieListRepository
@testable import MovieListUseCases

// MARK: - Tests
struct MovieListUseCaseTests {
    
    @Test("Fetch movies with reset pagination should reset page manager and return movies")
    func testFetchMoviesWithResetPaginationAndValidArray() async throws {
        // Given
        let repositoryMock = RepositoryMock()
        let mockPageManager = PageManagerMock(initialPage: 3)
        let sut = MovieListUseCase(movieListRepository: repositoryMock, pageManager: mockPageManager)
        
        // When
        let movies = try await sut.fetchMovies(resetPagination: true)
        
        // Then
        #expect(movies.isEmpty == false)
        #expect(repositoryMock.fetchNowPlayingMoviesCallCount == 1)
        #expect(repositoryMock.fetchNowPlayingMoviesPage == 1) // Should reset to page 1
        
        let currentPage = await mockPageManager.getCurrentPage()
        #expect(currentPage == 2) // Should increment after fetch
    }
    
    @Test("Fetch movies with reset pagination should return empty array when repository returns empty")
    func testFetchMoviesWithResetPaginationAndEmptyArray() async throws {
        // Given
        let repositoryMock = RepositoryMock()
        let emptyDTO = MoviesDTO.mock(
            page: 1,
            movies: [],
            totalPages: 1,
            totalResults: 0
        )
        repositoryMock.configure(moviesDTOToReturn: emptyDTO)
        
        let mockPageManager = PageManagerMock()
        let sut = MovieListUseCase(movieListRepository: repositoryMock, pageManager: mockPageManager)
        
        // When
        let movies = try await sut.fetchMovies(resetPagination: true)
        
        // Then
        #expect(movies.isEmpty)
        #expect(repositoryMock.fetchNowPlayingMoviesCallCount == 1)
    }
    
    @Test("Fetch movies with reset pagination should propagate repository errors")
    func testFetchMoviesWithResetPaginationAndError() async throws {
        // Given
        let repositoryMock = RepositoryMock()
        let expectedError = NSError(domain: "NetworkError", code: 500)
        repositoryMock.configure(shouldThrowError: true, errorToThrow: expectedError)
        
        let mockPageManager = PageManagerMock()
        let sut = MovieListUseCase(movieListRepository: repositoryMock, pageManager: mockPageManager)
        
        // When/Then
        await #expect(throws: expectedError) {
            try await sut.fetchMovies(resetPagination: true)
        }
        
        #expect(repositoryMock.fetchNowPlayingMoviesCallCount == 1)
    }
    
    @Test("Fetch movies without reset should use current page and return movies")
    func testFetchMoviesWithoutResetAndValidArray() async throws {
        // Given
        let repositoryMock = RepositoryMock()
        let mockPageManager = PageManagerMock(initialPage: 2)
        let sut = MovieListUseCase(movieListRepository: repositoryMock, pageManager: mockPageManager)
        
        // When
        let movies = try await sut.fetchMovies(resetPagination: false)
        
        // Then
        #expect(movies.isEmpty == false)
        #expect(repositoryMock.fetchNowPlayingMoviesCallCount == 1)
        #expect(repositoryMock.fetchNowPlayingMoviesPage == 2) // Should use current page
        
        let currentPage = await mockPageManager.getCurrentPage()
        #expect(currentPage == 3) // Should increment after fetch
    }
    
    @Test("Fetch movies should return empty array when hasMorePages returns false")
    func testFetchMoviesWhenHasMorePagesReturnsFalse() async throws {
        // Given
        let repositoryMock = RepositoryMock()
        let mockPageManager = PageManagerMock(initialPage: 5)
        await mockPageManager.setTotalPages(5)
        // Current page is 5, totalPages is 5, so hasMorePages() should return false
        
        let sut = MovieListUseCase(movieListRepository: repositoryMock, pageManager: mockPageManager)
        
        // When
        let movies = try await sut.fetchMovies(resetPagination: false)
        
        // Then
        #expect(movies.isEmpty)
        #expect(repositoryMock.fetchNowPlayingMoviesCallCount == 0) // Should not call repository
    }
}
