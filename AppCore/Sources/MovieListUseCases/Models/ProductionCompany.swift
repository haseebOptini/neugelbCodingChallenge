import Foundation

// MARK: - ProductionCompany
public struct ProductionCompany: Sendable, Equatable {
    public let id: Int
    public let logoPath: String?
    public let name: String
    public let originCountry: String?

    public init(id: Int, logoPath: String?, name: String, originCountry: String?) {
        self.id = id
        self.logoPath = logoPath
        self.name = name
        self.originCountry = originCountry
    }
}


