import Testing
import MovieListUseCases
@testable import MovieListUseCases

// MARK: - Tests
struct PageManagerActorTests {
    
    @Test("PageManagerActor should initialize with page 1")
    func testInitialPage() async {
        // Given/When
        let pageManager = PageManagerActor()
        
        // Then
        let currentPage = await pageManager.getCurrentPage()
        #expect(currentPage == 1)
    }
    
    @Test("PageManagerActor should initialize with custom initial page")
    func testInitialPageCustom() async {
        // Given/When
        let pageManager = PageManagerActor(initialPage: 5)
        
        // Then
        let currentPage = await pageManager.getCurrentPage()
        #expect(currentPage == 5)
    }
    
    @Test("getNextPage should return current page + 1")
    func testGetNextPage() async {
        // Given
        let pageManager = PageManagerActor(initialPage: 2)
        
        // When
        let nextPage = await pageManager.getNextPage()
        
        // Then
        #expect(nextPage == 3)
    }
    
    @Test("incrementPage should increment current page")
    func testIncrementPage() async {
        // Given
        let pageManager = PageManagerActor(initialPage: 1)
        
        // When
        await pageManager.incrementPage()
        
        // Then
        let currentPage = await pageManager.getCurrentPage()
        #expect(currentPage == 2)
    }
    
    @Test("incrementPage multiple times should increment correctly")
    func testIncrementPageMultipleTimes() async {
        // Given
        let pageManager = PageManagerActor(initialPage: 1)
        
        // When
        await pageManager.incrementPage()
        await pageManager.incrementPage()
        await pageManager.incrementPage()
        
        // Then
        let currentPage = await pageManager.getCurrentPage()
        #expect(currentPage == 4)
    }
    
    @Test("reset should reset page to 1")
    func testReset() async {
        // Given
        let pageManager = PageManagerActor(initialPage: 5)
        await pageManager.incrementPage()
        await pageManager.incrementPage()
        
        // When
        await pageManager.reset()
        
        // Then
        let currentPage = await pageManager.getCurrentPage()
        #expect(currentPage == 1)
    }
    
    @Test("reset should clear total pages")
    func testResetClearsTotalPages() async {
        // Given
        let pageManager = PageManagerActor()
        await pageManager.setTotalPages(10)
        
        // When
        await pageManager.reset()
        let currentPage = await pageManager.getCurrentPage()

        // Then
        let hasMorePages = await pageManager.hasMorePages()
        #expect(hasMorePages == true)
        #expect(currentPage == 1)
    }
    
    @Test("setTotalPages should set total pages")
    func testSetTotalPages() async {
        // Given
        let pageManager = PageManagerActor()
        
        // When
        await pageManager.setTotalPages(10)
        
        // Then
        let hasMorePages = await pageManager.hasMorePages()
        #expect(hasMorePages == true) // Current page is 1, totalPages is 10
    }
    
    @Test("hasMorePages should return true when totalPages is nil")
    func testHasMorePagesWhenTotalPagesIsNil() async {
        // Given
        let pageManager = PageManagerActor()
        
        // When
        let hasMorePages = await pageManager.hasMorePages()
        
        // Then
        #expect(hasMorePages == true)
    }
    
    @Test("hasMorePages should return true when current page is less than total pages")
    func testHasMorePagesWhenCurrentPageLessThanTotal() async {
        // Given
        let pageManager = PageManagerActor(initialPage: 2)
        await pageManager.setTotalPages(5)
        
        // When
        let hasMorePages = await pageManager.hasMorePages()
        
        // Then
        #expect(hasMorePages == true) // Current page is 2, totalPages is 5
    }
    
    @Test("hasMorePages should return false when current page equals total pages")
    func testHasMorePagesWhenCurrentPageEqualsTotal() async {
        // Given
        let pageManager = PageManagerActor(initialPage: 5)
        await pageManager.setTotalPages(5)
        
        // When
        let hasMorePages = await pageManager.hasMorePages()
        
        // Then
        #expect(hasMorePages == false)
    }
    
    @Test("hasMorePages should return false when current page is greater than total pages")
    func testHasMorePagesWhenCurrentPageGreaterThanTotal() async {
        // Given
        let pageManager = PageManagerActor(initialPage: 6)
        await pageManager.setTotalPages(5)
        
        // When
        let hasMorePages = await pageManager.hasMorePages()
        
        // Then
        #expect(hasMorePages == false)
    }
}

