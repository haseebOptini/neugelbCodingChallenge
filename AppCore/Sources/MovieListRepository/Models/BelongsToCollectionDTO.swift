import Foundation

// MARK: - BelongsToCollectionDTO
public struct BelongsToCollectionDTO: Sendable, Codable {
    public let id: Int
    public let name: String
    public let posterPath: String?
    public let backdropPath: String?
    
    public init(id: Int,
         name: String,
         posterPath: String?,
         backdropPath: String?) {
        self.id = id
        self.name = name
        self.posterPath = posterPath
        self.backdropPath = backdropPath
    }
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}


