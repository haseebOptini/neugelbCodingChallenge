import Foundation

// MARK: - MovieDetails
public struct MovieDetails: Sendable, Equatable {
    public let id: Int
    public let adult: Bool
    public let backdropPath: String?
    public let belongsToCollection: BelongsToCollection?
    public let budget: Int?
    public let genres: [Genre]?
    public let homepage: String?
    public let imdbId: String?
    public let originalLanguage: String
    public let originalTitle: String
    public let overview: String?
    public let popularity: Double?
    public let posterPath: String?
    public let productionCompanies: [ProductionCompany]?
    public let productionCountries: [ProductionCountry]?
    public let releaseDate: String?
    public let revenue: Int?
    public let runtime: Int?
    public let spokenLanguages: [SpokenLanguage]?
    public let status: String?
    public let tagline: String?
    public let title: String
    public let video: Bool
    public let voteAverage: Double?
    public let voteCount: Int?
}

