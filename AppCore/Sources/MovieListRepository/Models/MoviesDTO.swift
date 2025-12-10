public struct MoviesDTO: Sendable, Codable {
    public let page: Int
    public let movies: [MovieDTO]
    public let totalPages: Int
    public let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


