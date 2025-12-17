import Foundation
import MovieListUseCases

struct MovieDetailsDisplayModel: Equatable {
    let posterURL: String?
    let title: String
    let tagline: String?
    let overview: String?
    let genres: [GenreDisplayModel]
    let releaseDate: String?
    let runtime: String?
    let rating: String?
    let voteCount: String?
    let productionCompanies: [String]
    let productionCountries: [String]
    let spokenLanguages: [String]
    let budget: String?
    let revenue: String?
}

struct GenreDisplayModel: Equatable {
    let id: Int
    let name: String
}

