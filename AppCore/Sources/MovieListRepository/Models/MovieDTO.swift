import Foundation

public struct MovieDTO: Identifiable, Sendable, Codable {
    public let id: Int
    public let title: String
    public let originalTitle: String
    public let originalLanguage: String
    public let overview: String
    public let releaseDate: String
    public let posterPath: String?
    public var voteAverage: Double
    public var voteCount: Int
    public var adult: Bool
    public var backdropPath: String?
    public var genreIds: [Int]

    public init(id: Int,
                title: String,
                originalTitle: String,
                originalLanguage: String,
                overview: String,
                releaseDate: String,
                posterPath: String?,
                voteAverage: Double,
                voteCount: Int,
                adult: Bool,
                backdropPath: String? = nil,
                genreIds: [Int]) {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.overview = overview
        self.releaseDate = releaseDate
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIds = genreIds
    }
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
    }
}
