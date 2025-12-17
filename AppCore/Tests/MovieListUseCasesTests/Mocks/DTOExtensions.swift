import Foundation
import MovieListRepository

// MARK: - MovieDTO Mock Extension
extension MovieDTO {
    /// Creates a mock MovieDTO with customizable properties
    static func mock(
        id: Int = 1,
        title: String = "Test Movie",
        originalTitle: String = "Test Movie Original",
        originalLanguage: String = "en",
        overview: String = "Test overview",
        releaseDate: String = "2024-01-01",
        posterPath: String? = "/poster.jpg",
        voteAverage: Double = 8.5,
        voteCount: Int = 100,
        adult: Bool = false,
        backdropPath: String? = "/backdrop.jpg",
        genreIds: [Int] = [1, 2]
    ) -> MovieDTO {
        MovieDTO(
            id: id,
            title: title,
            originalTitle: originalTitle,
            originalLanguage: originalLanguage,
            overview: overview,
            releaseDate: releaseDate,
            posterPath: posterPath,
            voteAverage: voteAverage,
            voteCount: voteCount,
            adult: adult,
            backdropPath: backdropPath,
            genreIds: genreIds
        )
    }
}

// MARK: - MoviesDTO Mock Extension
extension MoviesDTO {
    /// Creates a mock MoviesDTO with customizable properties
    static func mock(
        page: Int = 1,
        movies: [MovieDTO]? = nil,
        totalPages: Int = 5,
        totalResults: Int = 50
    ) -> MoviesDTO {
        MoviesDTO(
            page: page,
            movies: movies ?? [.mock()],
            totalPages: totalPages,
            totalResults: totalResults
        )
    }
}

// MARK: - BelongsToCollectionDTO Mock Extension
extension BelongsToCollectionDTO {
    static func mock(
        id: Int = 1,
        name: String = "Test Collection",
        posterPath: String? = "/collection_poster.jpg",
        backdropPath: String? = "/collection_backdrop.jpg"
    ) -> BelongsToCollectionDTO {
        BelongsToCollectionDTO(
            id: id,
            name: name,
            posterPath: posterPath,
            backdropPath: backdropPath
        )
    }
}

// MARK: - GenreDTO Mock Extension
extension GenreDTO {
    static func mock(
        id: Int = 1,
        name: String = "Action"
    ) -> GenreDTO {
        GenreDTO(id: id, name: name)
    }
}

// MARK: - ProductionCompanyDTO Mock Extension
extension ProductionCompanyDTO {
    static func mock(
        id: Int = 1,
        logoPath: String? = "/logo.jpg",
        name: String = "Test Studio",
        originCountry: String? = "US"
    ) -> ProductionCompanyDTO {
        ProductionCompanyDTO(
            id: id,
            logoPath: logoPath,
            name: name,
            originCountry: originCountry
        )
    }
}

// MARK: - ProductionCountryDTO Mock Extension
extension ProductionCountryDTO {
    static func mock(
        iso31661: String = "US",
        name: String = "United States"
    ) -> ProductionCountryDTO {
        ProductionCountryDTO(iso31661: iso31661, name: name)
    }
}

// MARK: - SpokenLanguageDTO Mock Extension
extension SpokenLanguageDTO {
    static func mock(
        englishName: String? = "English",
        iso6391: String? = "en",
        name: String? = "English"
    ) -> SpokenLanguageDTO {
        SpokenLanguageDTO(
            englishName: englishName,
            iso6391: iso6391,
            name: name
        )
    }
}

// MARK: - MovieDetailsDTO Mock Extension
extension MovieDetailsDTO {
    static func mock(
        adult: Bool = false,
        backdropPath: String? = "/backdrop.jpg",
        belongsToCollection: BelongsToCollectionDTO? = .mock(),
        budget: Int? = 100000000,
        genres: [GenreDTO]? = [.mock(id: 1, name: "Action"), .mock(id: 2, name: "Drama")],
        homepage: String? = "https://example.com",
        id: Int = 1,
        imdbId: String? = "tt1234567",
        originalLanguage: String = "en",
        originalTitle: String = "Test Movie Original",
        overview: String? = "Test overview",
        popularity: Double? = 100.5,
        posterPath: String? = "/poster.jpg",
        productionCompanies: [ProductionCompanyDTO]? = [.mock()],
        productionCountries: [ProductionCountryDTO]? = [.mock()],
        releaseDate: String? = "2024-01-01",
        revenue: Int? = 200000000,
        runtime: Int? = 120,
        spokenLanguages: [SpokenLanguageDTO]? = [.mock()],
        status: String? = "Released",
        tagline: String? = "Test tagline",
        title: String = "Test Movie",
        video: Bool = false,
        voteAverage: Double? = 8.5,
        voteCount: Int? = 100
    ) -> MovieDetailsDTO {
        MovieDetailsDTO(
            adult: adult,
            backdropPath: backdropPath,
            belongsToCollection: belongsToCollection,
            budget: budget,
            genres: genres,
            homepage: homepage,
            id: id,
            imdbId: imdbId,
            originalLanguage: originalLanguage,
            originalTitle: originalTitle,
            overview: overview,
            popularity: popularity,
            posterPath: posterPath,
            productionCompanies: productionCompanies,
            productionCountries: productionCountries,
            releaseDate: releaseDate,
            revenue: revenue,
            runtime: runtime,
            spokenLanguages: spokenLanguages,
            status: status,
            tagline: tagline,
            title: title,
            video: video,
            voteAverage: voteAverage,
            voteCount: voteCount
        )
    }
}

