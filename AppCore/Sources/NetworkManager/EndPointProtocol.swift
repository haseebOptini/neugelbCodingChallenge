import Foundation

public protocol EndpointProtocol: Sendable {
    var url : String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var queryParameters: [URLQueryItem] { get }
    var headers: [String: String]? { get }
}
