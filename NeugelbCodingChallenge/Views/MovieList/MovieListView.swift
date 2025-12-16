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
                await viewModel.fetchNowPlayingMovies()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading, .initial:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        case .loaded(let moviesViewModels):
            moviesView(moviesListViewModels: moviesViewModels)
            
        case .error:
            ErrorView {
                await viewModel.fetchNowPlayingMovies()
            }
        }
    }
    
    private func moviesView(moviesListViewModels: [MovieViewModel]) -> some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 12) {
                if moviesListViewModels.isEmpty {
                    EmptyStateView()
                } else {
                    ForEach(moviesListViewModels, id: \.id) { movieViewModel in
                        MovieView(movieViewModel: movieViewModel)
                            .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
                            .contentShape(Rectangle())
                            .background(Color.white)
                            .onTapGesture {
                                coordinator.push(route: .movieDetail(movieViewModel.movie))
                            }
                            .task {
                               await viewModel.loadMoreIfNeeded(currentMovie: movieViewModel.movie)
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
