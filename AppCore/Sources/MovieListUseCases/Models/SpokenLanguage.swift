import Foundation

// MARK: - SpokenLanguage
public struct SpokenLanguage: Sendable, Equatable {
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
}


