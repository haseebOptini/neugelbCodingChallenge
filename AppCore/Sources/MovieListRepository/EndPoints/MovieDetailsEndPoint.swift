import NetworkManager
import Foundation

public struct MoviesDetailsEndPoint: EndpointProtocol {
    public let movieId: Int
    public var url: String = BaseURL.tmdb.rawValue
    
    public var path: String {
        return "\(Path.details.rawValue)/\(movieId)"
    }
    
    public var httpMethod: HTTPMethod = .get
    
    public var queryParameters: [URLQueryItem] {
        return [
            URLQueryItem(name: "language", value: "en-US"),
        ]
    }
    
    public init(movieId: Int) {
        self.movieId = movieId
    }
    
    // TODO: Move this from hard coded string to enum value
    public var headers: [String: String]? {
        return [
            "accept": "application/json",
            "Authorization": AccessToken.tmdb.rawValue
            
        ]
    }
}
