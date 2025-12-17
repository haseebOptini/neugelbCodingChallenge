import Foundation

public struct Movie: Sendable, Equatable, Hashable {
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
}

