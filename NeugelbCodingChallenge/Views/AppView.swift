import SwiftUI
import MovieListUseCases

struct AppView: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack {}
                .onAppear {
                    coordinator.push(route: .moviesList)
                }
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .moviesList:
                        MoviesListView(viewModel: MovieListViewModelFactory.makeMoviesListViewModel())
                            .navigationBarBackButtonHidden()
                    case .movieDetail(let movie):
                        MovieDetailsView(
                            viewModel: MovieListViewModelFactory.makeMovieDetailsViewModel(movie: movie)
                        )
                    }
                }
        }
    }
}

#Preview {
    AppView()
}
