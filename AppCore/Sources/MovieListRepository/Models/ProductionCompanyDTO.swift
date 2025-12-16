import Foundation

// MARK: - ProductionCompanyDTO
public struct ProductionCompanyDTO: Sendable, Codable {
    public let id: Int
    public let logoPath: String?
    public let name: String
    public let originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}


