import Foundation
import Testing
import MovieListUseCases
@testable import NeugelbCodingChallenge

// MARK: - Tests
struct SearchViewModelTests {
    
    @Test("Initial state should be initial")
    @MainActor
    func testInitialState() {
        // Given
        let mockUseCase = SearchMoviesUseCaseMock()
        
        // When
        let sut = SearchViewModel(searchMoviesUseCase: mockUseCase)
        
        // Then
        #expect(sut.state == .initial)
        #expect(sut.searchText == "")
        #expect(sut.isLoadingMore == false)
    }
    
    @Test("Search movies should update state to loading then loaded")
    @MainActor
    func testSearchMoviesSuccess() async {
        // Given
        let mockUseCase = SearchMoviesUseCaseMock()
        let movies = [
            Movie(
                id: 1,
                title: "Search Result",
                originalTitle: "Search Result Original",
                originalLanguage: "en",
                overview: "Search overview",
                releaseDate: "2024-01-01",
                posterPath: nil,
                voteAverage: 8.0,
                voteCount: 100,
                adult: false,
                backdropPath: nil,
                genreIds: [1]
            )
        ]
        mockUseCase.moviesToReturn = movies
        let sut = SearchViewModel(searchMoviesUseCase: mockUseCase)
        
        // When
        sut.searchText = "test"
        sut.searchMovies(query: "test")
        try? await Task.sleep(for: .milliseconds(500))
        
        // Then
        #expect(sut.state == .loaded(movies))
        #expect(mockUseCase.searchMoviesCallCount == 1)
        #expect(mockUseCase.searchMoviesQuery == "test")
    }
    
    @Test("Search movies should update state to empty when no results")
    @MainActor
    func testSearchMoviesEmpty() async {
        // Given
        let mockUseCase = SearchMoviesUseCaseMock()
        mockUseCase.moviesToReturn = []
        let sut = SearchViewModel(searchMoviesUseCase: mockUseCase)
        
        // When
        sut.searchText = "test"
        sut.searchMovies(query: "test")
        try? await Task.sleep(for: .milliseconds(500))
        
        // Then
        #expect(sut.state == .empty)
        #expect(mockUseCase.searchMoviesCallCount == 1)
    }
    
    @Test("Search movies should update state to error when use case throws error")
    @MainActor
    func testSearchMoviesError() async {
        // Given
        let mockUseCase = SearchMoviesUseCaseMock()
        mockUseCase.errorToThrow = NSError(domain: "TestError", code: 1)
        let sut = SearchViewModel(searchMoviesUseCase: mockUseCase)
        
        // When
        sut.searchText = "test"
        sut.searchMovies(query: "test")
        try? await Task.sleep(for: .milliseconds(500))
        
        // Then
        #expect(sut.state == .error)
        #expect(mockUseCase.searchMoviesCallCount == 1)
    }
}

