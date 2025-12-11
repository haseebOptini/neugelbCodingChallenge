import SwiftUI
import MovieListUseCases

struct MoviesListView: View {
    @StateObject var viewModel: MoviesListViewModel
    
    init(viewModel: MoviesListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            switch viewModel.viewState {
            case .loading, .initial:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loaded(_):
                MoviesView()
            case .error:
                ErrorView()
            }
        }
        .task {
            await viewModel.fetchNowPlayingMovies()
        }
    }
}


// TODO: Need to provide the proper implementation for MovieView
struct MoviesView: View {
    var body: some View {
        Text("MovieView")
    }
}
// TODO: Need to provide proper implementation for Error view and move this to a separate file.
struct ErrorView: View {
    var body: some View {
        Text("Error")
    }
}
