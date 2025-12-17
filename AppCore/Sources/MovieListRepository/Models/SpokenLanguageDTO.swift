import Foundation

// MARK: - SpokenLanguageDTO
public struct SpokenLanguageDTO: Sendable, Codable {
    public let englishName: String?
    public let iso6391: String?
    public let name: String?

    public init(englishName: String?,
         iso6391: String?,
         name: String?) {
        self.englishName = englishName
        self.iso6391 = iso6391
        self.name = name
    }
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name
    }
}


