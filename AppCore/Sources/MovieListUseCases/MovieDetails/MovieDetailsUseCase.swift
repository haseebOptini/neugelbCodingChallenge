import MovieListRepository
import Foundation

public struct MovieDetailsUseCase: MovieDetailsUseCaseProtocol {
    // MARK: - Private properties
    private let movieListRepository: MovieListRepositoryProtocol
    // MARK: - Init
    public init(movieListRepository: MovieListRepositoryProtocol) {
        self.movieListRepository = movieListRepository
    }
    
    // MARK: - Public methods
    public func fetchMovieDetails(id: Int) async throws -> MovieDetails {
        let moviesDetails = try await movieListRepository.fetchMovieDetails(id: id)
        return map(movieDetailsDto: moviesDetails)
    }

    // MARK: - Private methods
    private func map(movieDetailsDto: MovieDetailsDTO) -> MovieDetails {
        MovieDetails(
            id: movieDetailsDto.id,
            adult: movieDetailsDto.adult,
            backdropPath: movieDetailsDto.backdropPath,
            belongsToCollection: map(belongsToCollectionDto: movieDetailsDto.belongsToCollection),
            budget: movieDetailsDto.budget,
            genres: map(genresDto: movieDetailsDto.genres),
            homepage: movieDetailsDto.homepage,
            imdbId: movieDetailsDto.imdbId,
            originalLanguage: movieDetailsDto.originalLanguage,
            originalTitle: movieDetailsDto.originalTitle,
            overview: movieDetailsDto.overview,
            popularity: movieDetailsDto.popularity,
            posterPath: movieDetailsDto.posterPath,
            productionCompanies: map(productionCompaniesDto: movieDetailsDto.productionCompanies),
            productionCountries: map(productionCountriesDto: movieDetailsDto.productionCountries),
            releaseDate: movieDetailsDto.releaseDate,
            revenue: movieDetailsDto.revenue,
            runtime: movieDetailsDto.runtime,
            spokenLanguages: map(spokenLanguagesDto: movieDetailsDto.spokenLanguages),
            status: movieDetailsDto.status,
            tagline: movieDetailsDto.tagline,
            title: movieDetailsDto.title,
            video: movieDetailsDto.video,
            voteAverage: movieDetailsDto.voteAverage,
            voteCount: movieDetailsDto.voteCount
        )
    }
    
    private func map(belongsToCollectionDto: BelongsToCollectionDTO?) -> BelongsToCollection? {
        guard let dto = belongsToCollectionDto else { return nil }
        return BelongsToCollection(
            id: dto.id,
            name: dto.name,
            posterPath: dto.posterPath,
            backdropPath: dto.backdropPath
        )
    }
    
    private func map(genresDto: [GenreDTO]?) -> [Genre]? {
        guard let dto = genresDto else { return nil }
        return dto.map { Genre(id: $0.id, name: $0.name) }
    }
    
    private func map(productionCompaniesDto: [ProductionCompanyDTO]?) -> [ProductionCompany]? {
        guard let dto = productionCompaniesDto else { return nil }
        return dto.map { ProductionCompany(id: $0.id, logoPath: $0.logoPath, name: $0.name, originCountry: $0.originCountry) }
    }
    
    private func map(productionCountriesDto: [ProductionCountryDTO]?) -> [ProductionCountry]? {
        guard let dto = productionCountriesDto else { return nil }
        return dto.map { ProductionCountry(iso31661: $0.iso31661, name: $0.name) }
    }
    
    private func map(spokenLanguagesDto: [SpokenLanguageDTO]?) -> [SpokenLanguage]? {
        guard let dto = spokenLanguagesDto else { return nil }
        return dto.map { SpokenLanguage(englishName: $0.englishName, iso6391: $0.iso6391, name: $0.name) }
    }
}
