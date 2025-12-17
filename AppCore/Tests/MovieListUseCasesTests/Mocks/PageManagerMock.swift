import Foundation
import MovieListUseCases

// MARK: - Page Manager Mock
final class PageManagerMock: PageManagerProtocol {
    private var currentPage: Int
    private var totalPages: Int?
    
    init(initialPage: Int = 1) {
        self.currentPage = initialPage
        self.totalPages = nil
    }
    
    func getCurrentPage() async -> Int {
        return currentPage
    }
    
    func getNextPage() async -> Int {
        return currentPage + 1
    }
    
    func incrementPage() async {
        currentPage += 1
    }
    
    func reset() async {
        currentPage = 1
        totalPages = nil
    }
    
    func setTotalPages(_ totalPages: Int) async {
        self.totalPages = totalPages
    }
    
    func hasMorePages() async -> Bool {
        guard let totalPages = totalPages else {
            return true
        }
        return currentPage < totalPages
    }
}
