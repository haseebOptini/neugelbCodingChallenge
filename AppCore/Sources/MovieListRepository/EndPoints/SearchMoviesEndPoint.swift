import NetworkManager
import Foundation

public struct SearchMoviesEndPoint: EndpointProtocol {
    public let query: String
    public let page: Int
    
    public var url: String = BaseURL.tmdb.rawValue
    public var path: String = Path.searchMovies.rawValue
    public var httpMethod: HTTPMethod = .get
    
    public var queryParameters: [URLQueryItem] {
        return [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
    }
    
    public init(query: String, page: Int = 1) {
        self.query = query
        self.page = page
    }
    
    public var headers: [String: String]? {
        return [
            "accept": "application/json",
            "Authorization": AccessToken.tmdb.rawValue
        ]
    }
}

