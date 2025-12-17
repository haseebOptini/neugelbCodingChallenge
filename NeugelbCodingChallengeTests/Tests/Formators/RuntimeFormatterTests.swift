import Foundation
import Testing
@testable import NeugelbCodingChallenge

// MARK: - Tests
struct RuntimeFormatterTests {
    @Test("Format should return minutes only when less than 60 minutes")
    func testFormatMinutesOnly() {
        // Given
        let sut = RuntimeFormatter()
        
        // When
        let result = sut.format(30)
        
        // Then
        #expect(result == "30m")
    }

    @Test("Format should return hours only when exactly 60 minutes")
    func testFormatOneHour() {
        // Given
        let sut = RuntimeFormatter()
        
        // When
        let result = sut.format(60)
        
        // Then
        #expect(result == "1h")
    }

    @Test("Format should return hours and minutes when both present")
    func testFormatHoursAndMinutes() {
        // Given
        let sut = RuntimeFormatter()
        
        // When
        let result = sut.format(90)
        
        // Then
        #expect(result == "1h 30m")
    }
}
