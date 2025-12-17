import Foundation
import Testing
@testable import NeugelbCodingChallenge

// MARK: - Tests
struct MovieDateFormatterTests {
    
    @Test("Format should convert valid date string to long format")
    func testFormatValidDateString() {
        // Given
        let sut = MovieDateFormatter()
        let dateString = "2024-01-15"
        
        // When
        let result = sut.format(dateString)
        
        // Then
        #expect(result != dateString) // Should be formatted
        #expect(result.contains("2024")) // Should contain year
    }
    
    @Test("Format should return original string for invalid date format")
    func testFormatInvalidDateString() {
        // Given
        let sut = MovieDateFormatter()
        let invalidDateString = "invalid-date"
        
        // When
        let result = sut.format(invalidDateString)
        
        // Then
        #expect(result == invalidDateString)
    }
    
    @Test("Format should return original string for empty date string")
    func testFormatEmptyDateString() {
        // Given
        let sut = MovieDateFormatter()
        let emptyDateString = ""
        
        // When
        let result = sut.format(emptyDateString)
        
        // Then
        #expect(result == emptyDateString)
    }
}

