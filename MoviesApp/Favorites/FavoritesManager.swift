import Foundation

class FavoritesManager {

    static let favoritesManager = FavoritesManager()
    var favoriteIDs = [Int]()

    private init() {
        NotificationCenter.default.addObserver(self, selector: .editFavorites, name: .editedFavorite, object: nil)
        let defaults = UserDefaults.standard
        self.favoriteIDs = defaults.object(forKey: "FavoritesList") as? [Int] ?? [Int]()
    }

    @objc func editFavorites() {
        let defaults = UserDefaults.standard
        defaults.set(self.favoriteIDs, forKey: "FavoritesList")
    }
}

private extension Selector {
    static let editFavorites = #selector(FavoritesManager.editFavorites)
}

extension NSNotification.Name {
    static let editedFavorite = NSNotification.Name("EditedFavorite")
}

extension Movie {
    func isFavorite() -> Bool {
        return FavoritesManager.favoritesManager.favoriteIDs.contains(self.id)
    }

    func editFavorite() {
        if (isFavorite()) {
            FavoritesManager.favoritesManager.favoriteIDs = FavoritesManager.favoritesManager.favoriteIDs.filter { $0 != id }
        } else {
            if (!FavoritesManager.favoritesManager.favoriteIDs.contains(id)) {
                FavoritesManager.favoritesManager.favoriteIDs.append(id)
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .editedFavorite, object: self)
                }
            }
        }
    }
}
