import Foundation

class DiscoverViewModel {

    var movies = [Movie]()

    init() {
        getMovies(endpoint: .nowPlaying)
    }

    func getMovies(endpoint: MovieServiceAPI.Endpoint) {
        MovieServiceAPI.shared.fetchMovies(from: endpoint) { (result: Result<MoviesResponse, MovieServiceAPI.APIServiceError>) in
            switch result {
            case .success(let movieResponse):
                self.movies = movieResponse.results
                NotificationCenter.default.post(name: .didUpdateContent, object: self)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getMovie(at indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }

    func getSearch(with query: String) {
        MovieServiceAPI.shared.searchMovies(from: .search, query: query) { (result: Result<MoviesResponse, MovieServiceAPI.APIServiceError>) in
            switch result {
            case .success(let movieResponse):
                self.movies = movieResponse.results
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
