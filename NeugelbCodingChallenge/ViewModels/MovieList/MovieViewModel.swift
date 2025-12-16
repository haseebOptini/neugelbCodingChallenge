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
        movie.posterPath ?? ""
    }

    var id: Int { movie.id }
    
    // MARK: - Init
    init(movie: Movie) {
        self.movie = movie
    }
}
