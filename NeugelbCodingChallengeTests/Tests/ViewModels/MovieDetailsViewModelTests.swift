import Foundation
import Testing
import MovieListUseCases
@testable import NeugelbCodingChallenge

// MARK: - Tests
struct MovieDetailsViewModelTests {
    
    @Test("Initial state should be initial")
    @MainActor
    func testInitialState() {
        // Given
        let movie = Movie(
            id: 1,
            title: "Test Movie",
            originalTitle: "Test Movie Original",
            originalLanguage: "en",
            overview: "Test overview",
            releaseDate: "2024-01-01",
            posterPath: nil,
            voteAverage: 8.5,
            voteCount: 100,
            adult: false,
            backdropPath: nil,
            genreIds: [1, 2]
        )
        let mockUseCase = MovieDetailsUseCaseMock()
        let currencyFormatter = CurrencyFormatterMock()
        let runtimeFormatter = RuntimeFormatterMock()
        let dateFormatter = DateFormatterMock()
        
        // When
        let sut = MovieDetailsViewModel(
            movie: movie,
            movieDetailsUseCase: mockUseCase,
            currencyFormatter: currencyFormatter,
            runtimeFormatter: runtimeFormatter,
            dateFormatter: dateFormatter
        )
        
        // Then
        #expect(sut.state == .initial)
    }
    
    @Test("Fetch movie details should update state to loading then loaded")
    @MainActor
    func testFetchMovieDetailsSuccess() async {
        // Given
        let movie = Movie(
            id: 1,
            title: "Test Movie",
            originalTitle: "Test Movie Original",
            originalLanguage: "en",
            overview: "Test overview",
            releaseDate: "2024-01-01",
            posterPath: nil,
            voteAverage: 8.5,
            voteCount: 100,
            adult: false,
            backdropPath: nil,
            genreIds: [1, 2]
        )
        let mockUseCase = MovieDetailsUseCaseMock()
        let currencyFormatter = CurrencyFormatterMock()
        currencyFormatter.formattedStringToReturn = "$100,000,000"
        let runtimeFormatter = RuntimeFormatterMock()
        runtimeFormatter.formattedStringToReturn = "2h 0m"
        let dateFormatter = DateFormatterMock()
        dateFormatter.formattedStringToReturn = "January 15, 2024"
        
        let expectedDisplayModel = MovieDetailsDisplayModel(
            posterURL: "https://image.tmdb.org/t/p/w500/poster.jpg",
            title: "Test Movie",
            tagline: "Test tagline",
            overview: "Test overview",
            genres: [GenreDisplayModel(id: 1, name: "Action")],
            releaseDate: "January 15, 2024",
            runtime: "2h 0m",
            rating: "8.5",
            voteCount: "(100 votes)",
            productionCompanies: ["Test Studio"],
            productionCountries: ["United States"],
            spokenLanguages: ["English"],
            budget: "$100,000,000",
            revenue: "$100,000,000"
        )
        
        let sut = MovieDetailsViewModel(
            movie: movie,
            movieDetailsUseCase: mockUseCase,
            currencyFormatter: currencyFormatter,
            runtimeFormatter: runtimeFormatter,
            dateFormatter: dateFormatter
        )
        
        // When
        await sut.fetchMovieDetails()
        
        // Then
        if case .loaded(let displayModel) = sut.state {
            #expect(displayModel == expectedDisplayModel)
            #expect(mockUseCase.fetchMovieDetailsCallCount == 1)
            #expect(mockUseCase.fetchMovieDetailsId == movie.id)
        } else {
            Issue.record("Expected loaded state but got \(sut.state)")
        }
    }
    
    @Test("Fetch movie details should update state to error when use case throws error")
    @MainActor
    func testFetchMovieDetailsError() async {
        // Given
        let movie = Movie(
            id: 1,
            title: "Test Movie",
            originalTitle: "Test Movie Original",
            originalLanguage: "en",
            overview: "Test overview",
            releaseDate: "2024-01-01",
            posterPath: nil,
            voteAverage: 8.5,
            voteCount: 100,
            adult: false,
            backdropPath: nil,
            genreIds: [1, 2]
        )
        let mockUseCase = MovieDetailsUseCaseMock()
        mockUseCase.errorToThrow = NSError(domain: "TestError", code: 1)
        let currencyFormatter = CurrencyFormatterMock()
        let runtimeFormatter = RuntimeFormatterMock()
        let dateFormatter = DateFormatterMock()
        let sut = MovieDetailsViewModel(
            movie: movie,
            movieDetailsUseCase: mockUseCase,
            currencyFormatter: currencyFormatter,
            runtimeFormatter: runtimeFormatter,
            dateFormatter: dateFormatter
        )
        
        // When
        await sut.fetchMovieDetails()
        
        // Then
        #expect(sut.state == .error)
        #expect(mockUseCase.fetchMovieDetailsCallCount == 1)
    }
    
    @Test("Fetch movie details should use formatters correctly")
    @MainActor
    func testFetchMovieDetailsUsesFormatters() async {
        // Given
        let movie = Movie(
            id: 1,
            title: "Test Movie",
            originalTitle: "Test Movie Original",
            originalLanguage: "en",
            overview: "Test overview",
            releaseDate: "2024-01-01",
            posterPath: nil,
            voteAverage: 8.5,
            voteCount: 100,
            adult: false,
            backdropPath: nil,
            genreIds: [1, 2]
        )
        let mockUseCase = MovieDetailsUseCaseMock()
        let currencyFormatter = CurrencyFormatterMock()
        let runtimeFormatter = RuntimeFormatterMock()
        let dateFormatter = DateFormatterMock()
        let sut = MovieDetailsViewModel(
            movie: movie,
            movieDetailsUseCase: mockUseCase,
            currencyFormatter: currencyFormatter,
            runtimeFormatter: runtimeFormatter,
            dateFormatter: dateFormatter
        )
        
        // When
        await sut.fetchMovieDetails()
        
        // Then
        #expect(currencyFormatter.formatCallCount > 0)
        #expect(runtimeFormatter.formatCallCount > 0)
        #expect(dateFormatter.formatCallCount > 0)
    }
}

