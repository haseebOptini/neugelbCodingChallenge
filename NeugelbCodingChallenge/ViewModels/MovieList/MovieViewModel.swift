import Foundation
import MovieListUseCases

final class MovieViewModel: ObservableObject, Equatable {
    static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
        lhs.movie == rhs.movie
    }
    
    // MARK: - Private properties
    private let movie: Movie
    
    // MARK: - Init
    init(movie: Movie) {
        self.movie = movie
    }
}
