import Foundation
import MovieListUseCases

final class MovieDetailViewModel: ObservableObject, Equatable, Identifiable {
    static func == (lhs: MovieDetailViewModel, rhs: MovieDetailViewModel) -> Bool {
        lhs.movieDetails == rhs.movieDetails
    }
    
    let movieDetails: MovieDetails
    
    var id: Int { movieDetails.id }
    
    // MARK: - Init
    init(movieDetails: MovieDetails) {
        self.movieDetails = movieDetails
    }
}


