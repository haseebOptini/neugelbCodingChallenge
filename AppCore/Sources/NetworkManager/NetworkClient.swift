import Foundation
public final class NetworkClient: NetworkManagerProtocol {
    // MARK: - Private properties
    private let decoder: JSONDecoder
    private let session: URLSession
    
    // MARK: - Init
    public init(decoder: JSONDecoder = JSONDecoder(),
                session: URLSession = URLSession.shared) {
        self.decoder = decoder
        self.session = session
    }
    
    // MARK: - NetworkLayerProtocol
    public func request<T: Decodable>(_ endPoint: EndpointProtocol, type:T.Type ) async throws -> T {
        let request = try makeRequest(endPoint: endPoint)
        let (data, response) = try await session.data(for: request)

        guard let urlResponse = response as? HTTPURLResponse else {
            throw ServiceError.invalidResponse
        }

        switch urlResponse.statusCode {
        case 200...299:
            return try decoder.decode(type, from: data)
        default:
            throw ServiceError.invalidResponse
        }
    }

    // MARK: - Private properties
    private func makeRequest(endPoint: EndpointProtocol) throws -> URLRequest {
        var urlComponent = URLComponents(string: endPoint.url)
        urlComponent?.path = endPoint.path
        urlComponent?.queryItems = endPoint.queryParameters
        
        guard let url = urlComponent?.url else {
            throw ServiceError.invalidRequest
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = endPoint.headers

        return urlRequest
    }
}
