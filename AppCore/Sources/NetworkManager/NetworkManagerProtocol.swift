public protocol NetworkManagerProtocol {
    func request<T: Decodable>(_ endPoint: EndpointProtocol, type:T.Type ) async throws -> T

}
