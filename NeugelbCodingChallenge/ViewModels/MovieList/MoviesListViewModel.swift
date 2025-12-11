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
    @Published var viewState: ViewState = .initial
    
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
            viewState = .loading
            movies = try await movieListUseCase.fetchNowPlayingMovies()
            let moviesViewModel = mapMoviesToViewModels(movies)
            viewState = .loaded(moviesViewModel)
        } catch {
            print("alog::MovieListViewModel::fetchNowPlayingMovies::error: \(error)")
        }
    }
    
    // MARK: - Private properties
    private func mapMoviesToViewModels(_ movies: [Movie]) -> [MovieViewModel] {
        return movies.map { movie in
            MovieViewModel(movie: movie)
        }
    }
}
