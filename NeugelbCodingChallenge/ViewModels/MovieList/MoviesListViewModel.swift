//
//  MoviesListViewModel.swift
//  NeugelbCodingChallenge
//
//  Created by Abdul Haseeb on 11.12.25.
//

import MovieListUseCases
import Foundation

enum ViewState: Equatable {
    case initial
    case loading
    case loaded([MovieViewModel])
    case error
}

@MainActor
final class MoviesListViewModel: ObservableObject {
    // MARK: - Public properties
    @Published var state: ViewState = .initial
    @Published private(set) var isLoadingMore = false

    // MARK: - Private properties
    private let movieListUseCase: MovieListUseCaseProtocol
    private var movies: [Movie] = []
    // MARK: - Init
    init(movieListUseCase: MovieListUseCaseProtocol) {
        self.movieListUseCase = movieListUseCase
    }
    
    // TODO: Need to add the logic for pagination and refreshing logic
    func fetchNowPlayingMovies() async {
        do {
            state = .loading
            movies = try await movieListUseCase.fetchNowPlayingMovies()
            let moviesViewModel = mapMoviesToViewModels(movies)
            state = .loaded(moviesViewModel)
        } catch {
            print("alog::MovieListViewModel::fetchNowPlayingMovies::error: \(error)")
        }
    }
    func loadMoreIfNeeded(currentMovie: Movie?) {
        guard let currentMovie = currentMovie,
              case .loaded(let currentMovies) = state,
              let index = currentMovies.firstIndex(where: { $0.id == currentMovie.id }),
              index >= currentMovies.count else {
            return
        }
        
        // Load more if not already loading
        if !isLoadingMore {
            loadMoreMovies()
        }
    }
    // MARK: - Private properties
    private func mapMoviesToViewModels(_ movies: [Movie]) -> [MovieViewModel] {
        return movies.map { movie in
            MovieViewModel(movie: movie)
        }
    }

    private func loadMoreMovies() {
        guard !isLoadingMore else {
            return
        }
        print("we should call use case to load more movies")
    }
}
