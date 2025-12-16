public enum HTTPMethod: String, Sendable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

// TODO: add errors from TMDB.
public enum ServiceError: Error {
    case invalidURL
    case invalidResponse
    case invalidRequest
    case requestFailed
    
    public var errorMessage: String {
        switch self {
        case .invalidURL:
            return "URL is invalid"
        case .invalidResponse:
            return "Response in Invalid"
        case .requestFailed:
            return "Request Failed"
        case .invalidRequest:
            return "Request is Invalid"
        }
    }
}
