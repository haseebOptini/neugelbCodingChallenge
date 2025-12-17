import Foundation

// MARK: - MovieDetailsDTO
public struct MovieDetailsDTO: Identifiable, Sendable, Codable {
    public let adult: Bool
    public let backdropPath: String?
    public let belongsToCollection: BelongsToCollectionDTO?
    public let budget: Int?
    public let genres: [GenreDTO]?
    public let homepage: String?
    public let id: Int
    public let imdbId: String?
    public let originalLanguage: String
    public let originalTitle: String
    public let overview: String?
    public let popularity: Double?
    public let posterPath: String?
    public let productionCompanies: [ProductionCompanyDTO]?
    public let productionCountries: [ProductionCountryDTO]?
    public let releaseDate: String?
    public let revenue: Int?
    public let runtime: Int?
    public let spokenLanguages: [SpokenLanguageDTO]?
    public let status: String?
    public let tagline: String?
    public let title: String
    public let video: Bool
    public let voteAverage: Double?
    public let voteCount: Int?

    public init(adult: Bool,
         backdropPath: String?,
         belongsToCollection: BelongsToCollectionDTO?,
         budget: Int?,
         genres: [GenreDTO]?,
         homepage: String?,
         id: Int,
         imdbId: String?,
         originalLanguage: String,
         originalTitle: String,
         overview: String?,
         popularity: Double?,
         posterPath: String?,
         productionCompanies: [ProductionCompanyDTO]?,
         productionCountries: [ProductionCountryDTO]?,
         releaseDate: String?,
         revenue: Int?,
         runtime: Int?,
         spokenLanguages: [SpokenLanguageDTO]?,
         status: String?,
         tagline: String?,
         title: String,
         video: Bool,
         voteAverage: Double?,
         voteCount: Int?) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.belongsToCollection = belongsToCollection
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.id = id
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
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

