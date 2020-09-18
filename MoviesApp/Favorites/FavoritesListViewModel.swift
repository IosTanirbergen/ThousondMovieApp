import Foundation

class FavoritesListViewModel {

    var favoriteMovies = [Movie]()

    init() {
        updateFavoritesList()
    }

    func updateFavoritesList() {
        self.favoriteMovies = [Movie]()
        for movieId in FavoritesManager.favoritesManager.favoriteIDs {
            getFavoriteMovie(id: movieId)
        }
    }

    private func getFavoriteMovie(id: Int) {
        MovieServiceAPI.shared.fetchMovie(movieId: id) { (result: Result<Movie, MovieServiceAPI.APIServiceError>) in
            switch result {
                case .success(let movie):
                    self.favoriteMovies.append(movie)
                case .failure(let error):
                    print(error.localizedDescription)
             }
        }
        NotificationCenter.default.post(name: .didUpdateFavorites, object: self)
    }

    func getMovie(at indexPath: IndexPath) -> Movie {
        return favoriteMovies[indexPath.row]
    }

    func numberOfFavorites() -> Int {
        return self.favoriteMovies.count
    }

}
