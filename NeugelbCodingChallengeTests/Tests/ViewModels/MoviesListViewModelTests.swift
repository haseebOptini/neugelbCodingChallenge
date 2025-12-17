import Foundation
import Testing
import MovieListUseCases
@testable import NeugelbCodingChallenge

// MARK: - Tests
struct MoviesListViewModelTests {
    
    @Test("Initial state should be initial")
    @MainActor
    func testInitialState() {
        // Given
        let mockUseCase = MovieListUseCaseMock()
        
        // When
        let sut = MoviesListViewModel(movieListUseCase: mockUseCase)
        
        // Then
        #expect(sut.state == .initial)
        #expect(sut.isLoadingMore == false)
    }
    
    @Test("Fetch movies should update state to loading then loaded")
    @MainActor
    func testFetchMoviesSuccess() async {
        // Given
        let mockUseCase = MovieListUseCaseMock()
        let movies = [
            Movie(
                id: 1,
                title: "Test Movie",
                originalTitle: "Test Movie Original",
                originalLanguage: "en",
                overview: "Test overview",
                releaseDate: "2024-01-01",
                posterPath: "https://example.com/poster.jpg",
                voteAverage: 8.5,
                voteCount: 100,
                adult: false,
                backdropPath: nil,
                genreIds: [1, 2]
            )
        ]
        mockUseCase.moviesToReturn = movies
        let sut = MoviesListViewModel(movieListUseCase: mockUseCase)
        
        // When
        await sut.fetchMovies()
        
        // Then
        #expect(sut.state == .loaded(movies))
        #expect(mockUseCase.fetchMoviesCallCount == 1)
        #expect(mockUseCase.fetchMoviesResetPagination == true)
    }
    
    @Test("Fetch movies should update state to error when use case throws error")
    @MainActor
    func testFetchMoviesError() async {
        // Given
        let mockUseCase = MovieListUseCaseMock()
        mockUseCase.errorToThrow = NSError(domain: "TestError", code: 1)
        let sut = MoviesListViewModel(movieListUseCase: mockUseCase)
        
        // When
        await sut.fetchMovies()
        
        // Then
        #expect(sut.state == .error)
        #expect(mockUseCase.fetchMoviesCallCount == 1)
    }
    
    @Test("Fetch more movies if needed should load more when threshold is reached")
    @MainActor
    func testFetchMoreMoviesIfNeeded() async {
        // Given
        let mockUseCase = MovieListUseCaseMock()
        let movies = [
            Movie(
                id: 1,
                title: "Movie 1",
                originalTitle: "Movie 1 Original",
                originalLanguage: "en",
                overview: "Overview 1",
                releaseDate: "2024-01-01",
                posterPath: nil,
                voteAverage: 8.0,
                voteCount: 100,
                adult: false,
                backdropPath: nil,
                genreIds: [1]
            ),
            Movie(
                id: 2,
                title: "Movie 2",
                originalTitle: "Movie 2 Original",
                originalLanguage: "en",
                overview: "Overview 2",
                releaseDate: "2024-01-02",
                posterPath: nil,
                voteAverage: 7.5,
                voteCount: 50,
                adult: false,
                backdropPath: nil,
                genreIds: [2]
            )
        ]
        mockUseCase.moviesToReturn = movies
        let sut = MoviesListViewModel(movieListUseCase: mockUseCase)
        await sut.fetchMovies()
        
        let moreMovies = [
            Movie(
                id: 3,
                title: "Movie 3",
                originalTitle: "Movie 3 Original",
                originalLanguage: "en",
                overview: "Overview 3",
                releaseDate: "2024-01-03",
                posterPath: nil,
                voteAverage: 9.0,
                voteCount: 200,
                adult: false,
                backdropPath: nil,
                genreIds: [3]
            )
        ]
        mockUseCase.moviesToReturn = moreMovies
        
        // When
        await sut.fetchMoreMoviesIfNeeded(currentMovie: movies.last)
        
        // Then
        #expect(mockUseCase.fetchMoviesCallCount == 2)
        #expect(mockUseCase.fetchMoviesResetPagination == false)
    }
}

