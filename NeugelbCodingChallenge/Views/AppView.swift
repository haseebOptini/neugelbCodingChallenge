import SwiftUI

struct AppView: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack {}
                .onAppear {
                    coordinator.push(route: .articles)
                }
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .articles:
                        EmptyView()
                        MoviesListView(viewModel: MovieListViewModelFactory.makeMoviesListViewModel())
                            .navigationBarBackButtonHidden()
                    case .articlesDetail:
                        EmptyView()
                    }
                }
        }
    }
}

#Preview {
    AppView()
}
