public struct MoviesDTO: Sendable, Codable {
    public let page: Int
    public let movies: [MovieDTO]
    public let totalPages: Int
    public let totalResults: Int

    public init(page: Int,
         movies: [MovieDTO],
         totalPages: Int,
         totalResults: Int) {
        self.page = page
        self.movies = movies
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


