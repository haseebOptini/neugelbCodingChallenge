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

    public init(id: Int,
                adult: Bool,
                backdropPath: String?,
                belongsToCollection: BelongsToCollection?,
                budget: Int?,
                genres: [Genre]?,
                homepage: String?,
                imdbId: String?,
                originalLanguage: String,
                originalTitle: String,
                overview: String?,
                popularity: Double?,
                posterPath: String?,
                productionCompanies: [ProductionCompany]?,
                productionCountries: [ProductionCountry]?,
                releaseDate: String?,
                revenue: Int?,
                runtime: Int?,
                spokenLanguages: [SpokenLanguage]?,
                status: String?,
                tagline: String?,
                title: String,
                video: Bool,
                voteAverage: Double?,
                voteCount: Int?) {
        self.id = id
        self.adult = adult
        self.backdropPath = backdropPath
        self.belongsToCollection = belongsToCollection
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.imdbId = imdbId
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

