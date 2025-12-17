import Foundation
import MovieListUseCases
@testable import NeugelbCodingChallenge

// MARK: - MovieListUseCase Mock
final class MovieListUseCaseMock: MovieListUseCaseProtocol {
    var fetchMoviesCallCount = 0
    var fetchMoviesResetPagination: Bool?
    var moviesToReturn: [Movie] = []
    var errorToThrow: Error?
    
    func fetchMovies(resetPagination: Bool) async throws -> [Movie] {
        fetchMoviesCallCount += 1
        fetchMoviesResetPagination = resetPagination
        
        if let error = errorToThrow {
            throw error
        }
        
        return moviesToReturn
    }
}

// MARK: - SearchMoviesUseCase Mock
final class SearchMoviesUseCaseMock: SearchMoviesUseCaseProtocol {
    var searchMoviesCallCount = 0
    var searchMoviesQuery: String?
    var searchMoviesResetPagination: Bool?
    var moviesToReturn: [Movie] = []
    var errorToThrow: Error?
    
    func searchMovies(query: String, resetPagination: Bool) async throws -> [Movie] {
        searchMoviesCallCount += 1
        searchMoviesQuery = query
        searchMoviesResetPagination = resetPagination
        
        if let error = errorToThrow {
            throw error
        }
        
        return moviesToReturn
    }
}

// MARK: - MovieDetailsUseCase Mock
final class MovieDetailsUseCaseMock: MovieDetailsUseCaseProtocol {
    var fetchMovieDetailsCallCount = 0
    var fetchMovieDetailsId: Int?
    var movieDetailsToReturn: MovieDetails?
    var errorToThrow: Error?
    
    func fetchMovieDetails(id: Int) async throws -> MovieDetails {
        fetchMovieDetailsCallCount += 1
        fetchMovieDetailsId = id
        
        if let error = errorToThrow {
            throw error
        }
        
        return movieDetailsToReturn ?? createDefaultMovieDetails(id: id)
    }
    
    private func createDefaultMovieDetails(id: Int) -> MovieDetails {
        MovieDetails(
            id: id,
            adult: false,
            backdropPath: "/backdrop.jpg",
            belongsToCollection: nil,
            budget: 100000000,
            genres: [Genre(id: 1, name: "Action")],
            homepage: nil,
            imdbId: "tt1234567",
            originalLanguage: "en",
            originalTitle: "Test Movie Original",
            overview: "Test overview",
            popularity: 100.5,
            posterPath: "https://image.tmdb.org/t/p/w500/poster.jpg",
            productionCompanies: [ProductionCompany(id: 1, logoPath: nil, name: "Test Studio", originCountry: "US")],
            productionCountries: [ProductionCountry(iso31661: "US", name: "United States")],
            releaseDate: "2024-01-15",
            revenue: 200000000,
            runtime: 120,
            spokenLanguages: [SpokenLanguage(englishName: "English", iso6391: "en", name: "English")],
            status: "Released",
            tagline: "Test tagline",
            title: "Test Movie",
            video: false,
            voteAverage: 8.5,
            voteCount: 100
        )
    }
}

// MARK: - Formatter Mocks
final class CurrencyFormatterMock: CurrencyFormatterProtocol {
    var formatCallCount = 0
    var formatAmount: Int?
    var formattedStringToReturn = "$100"
    
    func format(_ amount: Int) -> String {
        formatCallCount += 1
        formatAmount = amount
        return formattedStringToReturn
    }
}

final class RuntimeFormatterMock: RuntimeFormatterProtocol {
    var formatCallCount = 0
    var formatMinutes: Int?
    var formattedStringToReturn = "2h 0m"
    
    func format(_ minutes: Int) -> String {
        formatCallCount += 1
        formatMinutes = minutes
        return formattedStringToReturn
    }
}

final class DateFormatterMock: DateFormatterProtocol {
    var formatCallCount = 0
    var formatDateString: String?
    var formattedStringToReturn = "January 15, 2024"
    
    func format(_ dateString: String) -> String {
        formatCallCount += 1
        formatDateString = dateString
        return formattedStringToReturn
    }
}

