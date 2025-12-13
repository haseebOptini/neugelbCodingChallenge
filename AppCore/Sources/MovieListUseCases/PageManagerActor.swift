import Foundation

public actor PageManagerActor: PageManagerActorProtocol {
    private var currentPage: Int
    
    public init(initialPage: Int = 1) {
        self.currentPage = initialPage
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
    }
}

