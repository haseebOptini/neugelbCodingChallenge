import MovieListUseCases
import Foundation

enum SearchViewState: Equatable {
    case initial
    case loading
    case loaded([Movie])
    case error
    case empty
}

@MainActor
final class SearchViewModel: ObservableObject {
    // MARK: - Public properties
    @Published var state: SearchViewState = .initial
    @Published var searchText: String = ""
    @Published private(set) var isLoadingMore = false
    
    // MARK: - Private properties
    private let debounceDelay: Duration = .milliseconds(400)
    private let searchMoviesUseCase: SearchMoviesUseCaseProtocol
    private var searchTask: Task<Void, Never>?
    private var loadMoreTask: Task<Void, Never>?
    private var movies: [Movie] = []
    private let loadMoreThreshold = 1
    
    // MARK: - Init
    init(searchMoviesUseCase: SearchMoviesUseCaseProtocol) {
        self.searchMoviesUseCase = searchMoviesUseCase
    }
    
    deinit {
        searchTask?.cancel()
        loadMoreTask?.cancel()
    }
    // MARK: - Public methods
    func searchMovies(query: String) {
        searchTask?.cancel()
        loadMoreTask?.cancel()
        loadMoreTask = nil
        state = .loading
        isLoadingMore = false

        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            state = .initial
            movies = []
            return
        }

        searchTask = Task {
            try? await Task.sleep(for: debounceDelay)
            guard !Task.isCancelled else { return }
            await searchMovies(query: query, resetPagination: true)
        }
    }
    
    func loadMoreIfNeeded(currentMovie: Movie?) async {
        guard let currentMovie = currentMovie,
              case .loaded(let currentMovies) = state,
              let index = currentMovies.firstIndex(where: { $0.id == currentMovie.id }),
              index >= currentMovies.count - loadMoreThreshold,
              !isLoadingMore else {
            return
        }
        await loadMoreMovies()
    }
    
    // MARK: - Private methods
    private func searchMovies(query: String, resetPagination: Bool) async {
        guard !Task.isCancelled else { return }
        do {
            let movies = try await searchMoviesUseCase.searchMovies(query: query, resetPagination: resetPagination)
            guard !Task.isCancelled else { return }
            self.movies = movies
            if movies.isEmpty {
                state = .empty
            } else {
                state = .loaded(movies)
            }
        } catch {
            guard !Task.isCancelled else { return }
            state = .error
        }
    }
    
    private func loadMoreMovies() async {
        guard !isLoadingMore, !searchText.isEmpty else {
            return
        }
        loadMoreTask = Task {
            isLoadingMore = true
            defer { isLoadingMore = false }
            do {
                let newMovies = try await searchMoviesUseCase.searchMovies(query: searchText, resetPagination: false)
                guard !Task.isCancelled else { return }
                let existingIds = Set(movies.map { $0.id })
                let uniqueNewMovies = newMovies.filter { !existingIds.contains($0.id) }
                movies.append(contentsOf: uniqueNewMovies)
                state = .loaded(movies)
            } catch {
                guard !Task.isCancelled else {
                    isLoadingMore = false
                    return
                }
            }
        }
    }
}

