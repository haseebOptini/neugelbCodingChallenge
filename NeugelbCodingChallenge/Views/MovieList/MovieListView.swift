import SwiftUI
import MovieListUseCases

struct MoviesListView: View {
    @StateObject var viewModel: MoviesListViewModel
    @EnvironmentObject private var coordinator: Coordinator
    
    init(viewModel: MoviesListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content
            .task {
                await viewModel.fetchMovies()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading, .initial:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        case .loaded(let movies):
            moviesView(movies: movies)
            
        case .error:
            ErrorView {
                await viewModel.fetchMovies()
            }
        }
    }
    
    private func moviesView(movies: [Movie]) -> some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 12) {
                if movies.isEmpty {
                    EmptyStateView()
                } else {
                    ForEach(movies, id: \.id) { movie in
                        MovieView(movie: movie)
                            .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
                            .contentShape(Rectangle())
                            .background(Color.white)
                            .onTapGesture {
                                coordinator.push(route: .movieDetail(movie))
                            }
                            .task {
                               await viewModel.fetchMoreMoviesIfNeeded(currentMovie: movie)
                            }
                    }
                }
                
                if viewModel.isLoadingMore {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .padding()
        }
        .background(Color.white)
    }
}
