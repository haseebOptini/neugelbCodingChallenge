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
    
    // TODO: Why we need to add ViewBuilder
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

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Text("No movies available")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 60)
        .padding()
    }
}

// TODO: Need to provide proper implementation for Error view and move this to a separate file.
// TODO: Need to make error view shared so we dont need to implement different error for each view.
struct ErrorView: View {
    let onRetry: () async -> Void
    
    init(onRetry: @escaping () async -> Void) {
        self.onRetry = onRetry
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundColor(.orange)
            
            Text("Unable to Load Movies")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("We encountered an error while fetching movies. Please check your connection and try again.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            
            Button(action: {
                Task {
                    await onRetry()
                }
            }) {
                Text("Retry")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: 200)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// TODO: Need to move this view in a separate file.
struct MovieView: View {
    private let movieViewModel: MovieViewModel

    init(movieViewModel: MovieViewModel) {
        self.movieViewModel = movieViewModel
    }

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ImageView(imageURL: movieViewModel.imageURL)
                .frame(width: 45, height: 45)
                .clipped()
                .cornerRadius(4)
                .background(Color.gray.opacity(0.1))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(movieViewModel.title.isEmpty ? "Untitled" : movieViewModel.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(movieViewModel.subtitle.isEmpty ? "No description available" : movieViewModel.subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(minHeight: 45)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 4)
        .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
        .background(Color.white)
    }
}

struct ImageView: View {
    let imageURL: String
    
    var body: some View {
        if let url = URL(string: imageURL), !imageURL.isEmpty {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                    
                case .failure:
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                @unknown default:
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        } else {
            Image(systemName: "photo")
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
