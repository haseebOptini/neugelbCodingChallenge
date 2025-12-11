import SwiftUI
import MovieListUseCases

struct MoviesListView: View {
    @StateObject var viewModel: MoviesListViewModel
    
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
            ErrorView()
        }
    }
    
    private func moviesView(moviesListViewModels: [MovieViewModel]) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(moviesListViewModels) { movieViewModel in
                    MovieView(movieViewModel: movieViewModel)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .onAppear {
                            viewModel.loadMoreIfNeeded(currentMovie: movieViewModel.movie)
                        }
                }
            }
            .padding()
            
            if viewModel.isLoadingMore {
                ProgressView()
                    .padding()
            }
        }
    }
}

// TODO: Need to provide the proper implementation for MovieView
struct MoviesView: View {
    var moviesListViewModels: [MovieViewModel]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(moviesListViewModels) { movieViewModel in
                    MovieView(movieViewModel: movieViewModel)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                }
            }
        }
    }
}
// TODO: Need to provide proper implementation for Error view and move this to a separate file.
struct ErrorView: View {
    var body: some View {
        Text("Error")
    }
}

// TODO: Need to move this view in
struct MovieView: View {
    private let movieViewModel: MovieViewModel

    init(movieViewModel: MovieViewModel) {
        self.movieViewModel = movieViewModel
    }

    var body: some View {
        HStack (spacing: 16) {
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
            VStack {
                Text(movieViewModel.title)
                    .font(.title)
                Text(movieViewModel.subtitle)
                    .font(.caption)
            }
            
        }
    }
}

