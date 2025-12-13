import NetworkManager
import Foundation

public struct NowPlayingMoviesEndPoint: EndpointProtocol {
    public let page: Int
    public var url: String = BaseURL.tmdb.rawValue
    
    public var path: String = Path.nowPlaying.rawValue
    
    public var httpMethod: HTTPMethod = .get
    
    public var queryParameters: [URLQueryItem] {
        return [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "\(page)"),
        ]
    }
    
    public init(page: Int = 1) {
        self.page = page
    }

    // TODO: Move this from hard coded string to enum value
    public var headers: [String: String]? {
        return [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNWRiZmJkYWVmNTFkNTUxNDNhZWI0Y2RhMDEwZTY5ZiIsIm5iZiI6MTQ2NTMxMTYyNi4wNDQsInN1YiI6IjU3NTZlMTg5OTI1MTQxNmUyZDAwMzBhOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.BZpM44cUZqQxRPApqlhU8IHCsRt3_80gw_LD3xOlviU"

        ]
    }
}
