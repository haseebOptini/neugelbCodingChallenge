import Foundation

public actor PageManagerActor: PageManagerActorProtocol {
    private var currentPage: Int
    private var totalPages: Int?
    
    public init(initialPage: Int = 1) {
        self.currentPage = initialPage
        self.totalPages = nil
    }
    
    public func getCurrentPage() async -> Int {
        return currentPage
    }
    
    public func getNextPage() async -> Int {
        return currentPage + 1
    }
    
    public func incrementPage() async {
        currentPage += 1
    }
    
    public func reset() async {
        currentPage = 1
        totalPages = nil
    }
    
    public func setTotalPages(_ totalPages: Int) async {
        self.totalPages = totalPages
    }
    
    public func hasMorePages() async -> Bool {
        guard let totalPages = totalPages else {
            return true
        }
        return currentPage < totalPages
    }
}

