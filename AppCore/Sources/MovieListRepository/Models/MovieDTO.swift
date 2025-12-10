import Foundation

public struct MovieDTO: Identifiable, Sendable, Codable {
    public let id: Int
    public let title: String
    public let originalTitle: String
    public let originalLanguage: String
    public let overview: String
    public let releaseDate: String
    public let posterPath: String
    public var voteAverage: Double
    public var voteCount: Int
    public var adult: Bool
    public var backdropPath: String?
    public var genreIds: [Int]
    
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
