import Foundation
import Testing
@testable import NeugelbCodingChallenge

// MARK: - Tests
struct CurrencyFormatterTests {
    
    @Test("Format should format small amounts correctly")
    func testFormatSmallAmount() {
        // Given
        let sut = CurrencyFormatter()
        
        // When
        let result = sut.format(100)
        
        // Then
        #expect(result.contains("$"))
        #expect(result.contains("100"))
    }
    
    @Test("Format should format large amounts correctly")
    func testFormatLargeAmount() {
        // Given
        let sut = CurrencyFormatter()
        
        // When
        let result = sut.format(1000000)
        
        // Then
        #expect(result.contains("$"))
        #expect(result.contains("1,000,000") || result.contains("1000000"))
    }
}

