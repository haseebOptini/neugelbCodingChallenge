enum BaseURL: String {
    case tmdb = "https://api.themoviedb.org"
}

public enum ImageBaseURL: String {
    case tmdb = "https://image.tmdb.org/t/p/w500"
}

enum Path: String
{
    case nowPlaying = "/3/movie/now_playing"
    case details = "/3/movie"
    case searchMovies = "/3/search/movie"
}

enum AccessToken: String {
    case tmdb = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNWRiZmJkYWVmNTFkNTUxNDNhZWI0Y2RhMDEwZTY5ZiIsIm5iZiI6MTQ2NTMxMTYyNi4wNDQsInN1YiI6IjU3NTZlMTg5OTI1MTQxNmUyZDAwMzBhOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.BZpM44cUZqQxRPApqlhU8IHCsRt3_80gw_LD3xOlviU"
}

enum ApiKey: String {
    case tmdb = "fdbbfdaef51d55143ae4cd1010e69f"
}

