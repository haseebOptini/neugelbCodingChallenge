import Foundation

// MARK: - SpokenLanguageDTO
public struct SpokenLanguageDTO: Sendable, Codable {
    public let englishName: String?
    public let iso6391: String?
    public let name: String?
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name
    }
}


