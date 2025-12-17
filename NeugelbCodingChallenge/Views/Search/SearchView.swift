import SwiftUI
import MovieListUseCases

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    @EnvironmentObject private var coordinator: Coordinator
    
    init(viewModel: SearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content
            .searchable(text: $viewModel.searchText, prompt: "Search movies...")
            .onChange(of: viewModel.searchText) { oldValue, newValue in
                viewModel.searchMovies(query: newValue)
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .initial:
            initialView
            
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        case .loaded(let movies):
            moviesListView(movies: movies)
            
        case .empty:
            emptyStateView
            
        case .error:
            ErrorView {
                if !viewModel.searchText.isEmpty {
                    viewModel.searchMovies(query: viewModel.searchText)
                }
            }
        }
    }
    
    private var initialView: some View {
        VStack {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            Text("Search for movies")
                .font(.title2)
                .foregroundColor(.secondary)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var emptyStateView: some View {
        VStack {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            Text("No results found")
                .font(.title2)
                .foregroundColor(.secondary)
                .padding(.top, 8)
            Text("Try searching with different keywords")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func moviesListView(movies: [Movie]) -> some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 12) {
                ForEach(movies, id: \.id) { movie in
                    MovieView(movie: movie)
                        .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
                        .contentShape(Rectangle())
                        .background(Color.white)
                        .onTapGesture {
                            coordinator.push(route: .movieDetail(movie))
                        }
                        .task {
                            await viewModel.loadMoreIfNeeded(currentMovie: movie)
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

