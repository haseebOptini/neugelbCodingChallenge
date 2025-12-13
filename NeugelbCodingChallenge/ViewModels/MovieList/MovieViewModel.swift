import Foundation
import MovieListUseCases

final class MovieViewModel: ObservableObject, Equatable, Identifiable {
    static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
        lhs.movie == rhs.movie
    }
    let movie: Movie
    var title: String {
        movie.title
    }

    var subtitle: String {
        movie.overview
    }
    var imageURL: String {
        guard let posterPath = movie.posterPath else {
            return ""
        }
        return MovieViewModel.baseUrl + posterPath
    }

    var id: Int { movie.id }
    // MARK: - Private properties
    private static let baseUrl = "https://image.tmdb.org/t/p/w500"
    
    // MARK: - Init
    init(movie: Movie) {
        self.movie = movie
    }
}
