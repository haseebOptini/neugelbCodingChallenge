import Foundation
import MovieListUseCases

enum Route: Hashable {
    case movieDetail(Movie)
}

final class Coordinator: ObservableObject {
    // MARK: - Public properties
    @Published var path: [Route] = []
    // MARK: - Init
    init() { }
}

extension Coordinator {
    func push(route: Route) {
        path.append(route)
    }
    
    func pop() {
        self.path.removeLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
