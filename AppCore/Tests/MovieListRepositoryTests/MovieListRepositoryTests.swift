import Foundation
import Testing
import NetworkManager
import MovieListRepository

// MARK: - Tests
struct MovieListRepositoryTests {
    
    // MARK: - Fetch Now Playing Movies Tests
    
    @Test("Fetch now playing movies should return MoviesDTO when network manager succeeds")
    func testFetchNowPlayingMoviesSuccess() async throws {
        // Given
        let mockNetworkManager = NetworkManagerMock()
        let expectedDTO = MoviesDTO.mock(page: 1)
        mockNetworkManager.dtoToReturn = expectedDTO
        let sut = MovieListRepository(networkManager: mockNetworkManager)
        
        // When
        let result = try await sut.fetchNowPlayingMovies(page: 1)
        
        // Then
        #expect(result.page == expectedDTO.page)
        #expect(result.movies.count == expectedDTO.movies.count)
        #expect(mockNetworkManager.requestCallCount == 1)
        #expect(mockNetworkManager.requestEndpoint is NowPlayingMoviesEndPoint)
        
        if let endpoint = mockNetworkManager.requestEndpoint as? NowPlayingMoviesEndPoint {
            #expect(endpoint.page == 1)
        }
    }
    
    @Test("Fetch now playing movies should propagate error when network manager throws error")
    func testFetchNowPlayingMoviesError() async throws {
        // Given
        let mockNetworkManager = NetworkManagerMock()
        let expectedError = NSError(domain: "NetworkError", code: 500)
        mockNetworkManager.errorToThrow = expectedError
        let sut = MovieListRepository(networkManager: mockNetworkManager)
        
        // When/Then
        await #expect(throws: NSError.self) {
            try await sut.fetchNowPlayingMovies(page: 1)
        }
        
        #expect(mockNetworkManager.requestCallCount == 1)
    }
    
    @Test("Fetch now playing movies should pass correct page to endpoint")
    func testFetchNowPlayingMoviesPassesCorrectPage() async throws {
        // Given
        let mockNetworkManager = NetworkManagerMock()
        let expectedDTO = MoviesDTO.mock(page: 3)
        mockNetworkManager.dtoToReturn = expectedDTO
        let sut = MovieListRepository(networkManager: mockNetworkManager)
        
        // When
        _ = try await sut.fetchNowPlayingMovies(page: 3)
        
        // Then
        if let endpoint = mockNetworkManager.requestEndpoint as? NowPlayingMoviesEndPoint {
            #expect(endpoint.page == 3)
        }
    }
    
    @Test("Fetch now playing movies should use default page when page is not provided")
    func testFetchNowPlayingMoviesDefaultPage() async throws {
        // Given
        let mockNetworkManager = NetworkManagerMock()
        let expectedDTO = MoviesDTO.mock(page: 1)
        mockNetworkManager.dtoToReturn = expectedDTO
        let sut = MovieListRepository(networkManager: mockNetworkManager)
        
        // When - calling without page parameter (using default)
        _ = try await sut.fetchNowPlayingMovies()
        
        // Then
        if let endpoint = mockNetworkManager.requestEndpoint as? NowPlayingMoviesEndPoint {
            #expect(endpoint.page == 1) // Should default to 1
        }
    }
    
    @Test("Fetch now playing movies should request MoviesDTO type from network manager")
    func testFetchNowPlayingMoviesRequestType() async throws {
        // Given
        let mockNetworkManager = NetworkManagerMock()
        let expectedDTO = MoviesDTO.mock()
        mockNetworkManager.dtoToReturn = expectedDTO
        let sut = MovieListRepository(networkManager: mockNetworkManager)
        
        // When
        _ = try await sut.fetchNowPlayingMovies(page: 1)
        
        // Then
        #expect(mockNetworkManager.requestType == MoviesDTO.self)
    }
    
    // MARK: - Fetch Movie Details Tests
    
    @Test("Fetch movie details should return MovieDetailsDTO when network manager succeeds")
    func testFetchMovieDetailsSuccess() async throws {
        // Given
        let mockNetworkManager = NetworkManagerMock()
        let expectedDTO = MovieDetailsDTO.mock(id: 123)
        mockNetworkManager.dtoToReturn = expectedDTO
        let sut = MovieListRepository(networkManager: mockNetworkManager)
        
        // When
        let result = try await sut.fetchMovieDetails(id: 123)
        
        // Then
        #expect(result.id == expectedDTO.id)
        #expect(result.title == expectedDTO.title)
        #expect(mockNetworkManager.requestCallCount == 1)
        #expect(mockNetworkManager.requestEndpoint is MoviesDetailsEndPoint)
        
        if let endpoint = mockNetworkManager.requestEndpoint as? MoviesDetailsEndPoint {
            #expect(endpoint.movieId == 123)
        }
    }
    
    @Test("Fetch movie details should propagate error when network manager throws error")
    func testFetchMovieDetailsError() async throws {
        // Given
        let mockNetworkManager = NetworkManagerMock()
        let expectedError = NSError(domain: "NetworkError", code: 404)
        mockNetworkManager.errorToThrow = expectedError
        let sut = MovieListRepository(networkManager: mockNetworkManager)
        
        // When/Then
        await #expect(throws: NSError.self) {
            try await sut.fetchMovieDetails(id: 123)
        }
        
        #expect(mockNetworkManager.requestCallCount == 1)
    }
    
    @Test("Fetch movie details should request MovieDetailsDTO type from network manager")
    func testFetchMovieDetailsRequestType() async throws {
        // Given
        let mockNetworkManager = NetworkManagerMock()
        let expectedDTO = MovieDetailsDTO.mock()
        mockNetworkManager.dtoToReturn = expectedDTO
        let sut = MovieListRepository(networkManager: mockNetworkManager)
        
        // When
        _ = try await sut.fetchMovieDetails(id: 123)
        
        // Then
        #expect(mockNetworkManager.requestType == MovieDetailsDTO.self)
    }
    
    // MARK: - Search Movies Tests
    
    @Test("Search movies should return MoviesDTO when network manager succeeds")
    func testSearchMoviesSuccess() async throws {
        // Given
        let mockNetworkManager = NetworkManagerMock()
        let expectedDTO = MoviesDTO.mock(page: 1)
        mockNetworkManager.dtoToReturn = expectedDTO
        let sut = MovieListRepository(networkManager: mockNetworkManager)
        
        // When
        let result = try await sut.searchMovies(query: "batman", page: 1)
        
        // Then
        #expect(result.page == expectedDTO.page)
        #expect(mockNetworkManager.requestCallCount == 1)
        #expect(mockNetworkManager.requestEndpoint is SearchMoviesEndPoint)
        
        if let endpoint = mockNetworkManager.requestEndpoint as? SearchMoviesEndPoint {
            #expect(endpoint.query == "batman")
            #expect(endpoint.page == 1)
        }
    }
    
    @Test("Search movies should propagate error when network manager throws error")
    func testSearchMoviesError() async throws {
        // Given
        let mockNetworkManager = NetworkManagerMock()
        let expectedError = NSError(domain: "NetworkError", code: 500)
        mockNetworkManager.errorToThrow = expectedError
        let sut = MovieListRepository(networkManager: mockNetworkManager)
        
        // When/Then
        await #expect(throws: NSError.self) {
            try await sut.searchMovies(query: "test", page: 1)
        }
        
        #expect(mockNetworkManager.requestCallCount == 1)
    }
    
    @Test("Search movies should pass correct query and page to endpoint")
    func testSearchMoviesPassesCorrectParameters() async throws {
        // Given
        let mockNetworkManager = NetworkManagerMock()
        let expectedDTO = MoviesDTO.mock(page: 2)
        mockNetworkManager.dtoToReturn = expectedDTO
        let sut = MovieListRepository(networkManager: mockNetworkManager)
        
        // When
        _ = try await sut.searchMovies(query: "superman", page: 2)
        
        // Then
        if let endpoint = mockNetworkManager.requestEndpoint as? SearchMoviesEndPoint {
            #expect(endpoint.query == "superman")
            #expect(endpoint.page == 2)
        }
    }
    
    @Test("Search movies should use default page when page is not provided")
    func testSearchMoviesDefaultPage() async throws {
        // Given
        let mockNetworkManager = NetworkManagerMock()
        let expectedDTO = MoviesDTO.mock(page: 1)
        mockNetworkManager.dtoToReturn = expectedDTO
        let sut = MovieListRepository(networkManager: mockNetworkManager)
        
        // When - calling without page parameter (using default)
        _ = try await sut.searchMovies(query: "test")
        
        // Then
        if let endpoint = mockNetworkManager.requestEndpoint as? SearchMoviesEndPoint {
            #expect(endpoint.page == 1) // Should default to 1
        }
    }
    
    @Test("Search movies should request MoviesDTO type from network manager")
    func testSearchMoviesRequestType() async throws {
        // Given
        let mockNetworkManager = NetworkManagerMock()
        let expectedDTO = MoviesDTO.mock()
        mockNetworkManager.dtoToReturn = expectedDTO
        let sut = MovieListRepository(networkManager: mockNetworkManager)
        
        // When
        _ = try await sut.searchMovies(query: "test", page: 1)
        
        // Then
        #expect(mockNetworkManager.requestType == MoviesDTO.self)
    }
}
