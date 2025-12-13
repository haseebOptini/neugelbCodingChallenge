import Foundation

public struct Movie: Sendable, Equatable {
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
}

