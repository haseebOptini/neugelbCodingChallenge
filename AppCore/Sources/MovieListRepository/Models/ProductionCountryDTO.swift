import Foundation

// MARK: - ProductionCountryDTO
public struct ProductionCountryDTO: Sendable, Codable {
    public let iso31661: String
    public let name: String
    
    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
}


