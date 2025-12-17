import Foundation
import NetworkManager
import MovieListRepository

// MARK: - Network Manager Mock
final class NetworkManagerMock: NetworkManagerProtocol {
    var requestCallCount = 0
    var requestEndpoint: EndpointProtocol?
    var requestType: Any.Type?
    var dtoToReturn: Any?
    var errorToThrow: Error?
    
    func request<T: Decodable>(_ endPoint: EndpointProtocol, type: T.Type) async throws -> T {
        requestCallCount += 1
        requestEndpoint = endPoint
        requestType = type
        
        if let error = errorToThrow {
            throw error
        }
        
        if let dto = dtoToReturn as? T {
            return dto
        }
        
        throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "No DTO configured"])
    }
}

