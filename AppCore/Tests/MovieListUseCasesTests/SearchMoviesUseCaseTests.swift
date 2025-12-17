import Foundation
import Testing
import MovieListUseCases
import MovieListRepository
@testable import MovieListUseCases

// MARK: - Tests
struct SearchMoviesUseCaseTests {
    
    @Test("Search movies with reset pagination should reset page manager and return movies")
    func testSearchMoviesWithResetPaginationAndValidArray() async throws {
        // Given
        let repositoryMock = RepositoryMock()
        let mockPageManager = PageManagerMock(initialPage: 3)
        let sut = SearchMoviesUseCase(movieListRepository: repositoryMock, pageManager: mockPageManager)
        
        // When
        let movies = try await sut.searchMovies(query: "test", resetPagination: true)
        
        // Then
        #expect(movies.isEmpty == false)
        #expect(repositoryMock.searchMoviesCallCount == 1)
        #expect(repositoryMock.searchMoviesQuery == "test")
        #expect(repositoryMock.searchMoviesPage == 1) // Should reset to page 1
        
        let currentPage = await mockPageManager.getCurrentPage()
        #expect(currentPage == 2) // Should increment after fetch
    }
    
    @Test("Search movies with reset pagination should return empty array when repository returns empty")
    func testSearchMoviesWithResetPaginationAndEmptyArray() async throws {
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
        let sut = SearchMoviesUseCase(movieListRepository: repositoryMock, pageManager: mockPageManager)
        
        // When
        let movies = try await sut.searchMovies(query: "test", resetPagination: true)
        
        // Then
        #expect(movies.isEmpty)
        #expect(repositoryMock.searchMoviesCallCount == 1)
        #expect(repositoryMock.searchMoviesQuery == "test")
    }
    
    @Test("Search movies with reset pagination should propagate repository errors")
    func testSearchMoviesWithResetPaginationAndError() async throws {
        // Given
        let repositoryMock = RepositoryMock()
        let expectedError = NSError(domain: "NetworkError", code: 500)
        repositoryMock.configure(shouldThrowError: true, errorToThrow: expectedError)
        
        let mockPageManager = PageManagerMock()
        let sut = SearchMoviesUseCase(movieListRepository: repositoryMock, pageManager: mockPageManager)
        
        // When/Then
        await #expect(throws: NSError.self) {
            try await sut.searchMovies(query: "test", resetPagination: true)
        }
        
        #expect(repositoryMock.searchMoviesCallCount == 1)
    }
    
    @Test("Search movies without reset should use current page and return movies")
    func testSearchMoviesWithoutResetAndValidArray() async throws {
        // Given
        let repositoryMock = RepositoryMock()
        let mockPageManager = PageManagerMock(initialPage: 2)
        let sut = SearchMoviesUseCase(movieListRepository: repositoryMock, pageManager: mockPageManager)
        
        // When
        let movies = try await sut.searchMovies(query: "test", resetPagination: false)
        
        // Then
        #expect(movies.isEmpty == false)
        #expect(repositoryMock.searchMoviesCallCount == 1)
        #expect(repositoryMock.searchMoviesQuery == "test")
        #expect(repositoryMock.searchMoviesPage == 2) // Should use current page
        
        let currentPage = await mockPageManager.getCurrentPage()
        #expect(currentPage == 3) // Should increment after fetch
    }
    
    @Test("Search movies should return empty array when hasMorePages returns false")
    func testSearchMoviesWhenHasMorePagesReturnsFalse() async throws {
        // Given
        let repositoryMock = RepositoryMock()
        let mockPageManager = PageManagerMock(initialPage: 5)
        await mockPageManager.setTotalPages(5)

        let sut = SearchMoviesUseCase(movieListRepository: repositoryMock, pageManager: mockPageManager)
        
        // When
        let movies = try await sut.searchMovies(query: "test", resetPagination: false)
        
        // Then
        #expect(movies.isEmpty)
        #expect(repositoryMock.searchMoviesCallCount == 0) // Should not call repository
    }
}
