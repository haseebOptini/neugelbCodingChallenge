import Foundation
import MovieListUseCases

final class MovieViewModel: ObservableObject, Equatable, Identifiable {
    static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
        lhs.movie == rhs.movie
    }
    
    var title: String {
        movie.title
    }

    var subtitle: String {
        movie.overview
    }

    var id: Int { movie.id }
    // MARK: - Private properties
    let movie: Movie
    
    // MARK: - Init
    init(movie: Movie) {
        self.movie = movie
    }
}
