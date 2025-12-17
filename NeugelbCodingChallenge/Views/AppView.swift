import SwiftUI
import MovieListUseCases

struct AppView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack(path: $coordinator.path) {
                MoviesListView(viewModel: ViewModelFactory.makeMoviesListViewModel())
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .movieDetail(let movie):
                            MovieDetailsView(
                                viewModel: ViewModelFactory.makeMovieDetailsViewModel(movie: movie)
                            )
                        }
                    }
            }
            .tabItem {
                Label("Upcoming Movies", systemImage: "film")
            }
            
            NavigationStack(path: $coordinator.path) {
                SearchView(viewModel: ViewModelFactory.makeSearchViewModel())
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .movieDetail(let movie):
                            MovieDetailsView(
                                viewModel: ViewModelFactory.makeMovieDetailsViewModel(movie: movie)
                            )
                        }
                    }
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
        }
    }
}

#Preview {
    AppView()
}
