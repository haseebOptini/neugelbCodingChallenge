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
    case loaded([Movie])
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
    private let loadMoreThreshold = 1
    
    // MARK: - Init
    init(movieListUseCase: MovieListUseCaseProtocol) {
        self.movieListUseCase = movieListUseCase
    }
    
    func fetchNowPlayingMovies() async {
        do {
            state = .loading
            let movies = try await movieListUseCase.fetchMovies(resetPagination: true)
            self.movies = movies
            state = .loaded(movies)
        } catch {
            print("alog::MovieListViewModel::fetchNowPlayingMovies::error: \(error)")
            state = .error
        }
    }

    // TODO: Need to improve naming for better code readability. also check if we can make movie non optional
    func loadMoreIfNeeded(currentMovie: Movie?) async {
        guard let currentMovie = currentMovie,
              case .loaded(let currentMovies) = state,
              let index = currentMovies.firstIndex(where: { $0.id == currentMovie.id }),
              index >= currentMovies.count - loadMoreThreshold,
              !isLoadingMore else {
            return
        }
        print("alog::This is the time that we start loading more movies")
        // Load more if not already loading
        await loadMoreMovies()
    }

    private func loadMoreMovies() async {
        guard !isLoadingMore else {
            return
        }
        isLoadingMore = true
        do {
            let newMovies = try await movieListUseCase.fetchMovies(resetPagination: false)
            let existingIds = Set(movies.map { $0.id })
            let uniqueNewMovies = newMovies.filter { !existingIds.contains($0.id) }
            
            if !uniqueNewMovies.isEmpty {
                movies.append(contentsOf: uniqueNewMovies)
                if case .loaded = state {
                    state = .loaded(movies)
                }
            }
        } catch {
            print("alog::MovieListViewModel::loadMoreMovies::error: \(error)")
        }
        isLoadingMore = false
    }
}
