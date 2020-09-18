import Foundation
import UIKit

class FavoritesListTableViewController: UITableViewController {

    let favoritesViewModel = FavoritesListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cell: FavoriteTableViewCell.self)
        tableView.backgroundColor = .black

        NotificationCenter.default.addObserver(self, selector: .refreshFavorites, name: .didUpdateFavorites, object: nil)
        NotificationCenter.default.addObserver(self, selector: .deletedFavorite, name: .didDeleteFavorite, object: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoritesViewModel.numberOfFavorites()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: FavoriteTableViewCell.self, at: indexPath)
        cell.setup(movie: favoritesViewModel.getMovie(at: indexPath))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.present(DetailViewController(movie: favoritesViewModel.getMovie(at: indexPath)), animated: false, completion: nil)
    }

    @objc func refreshTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    @objc func deletedFavorite() {
        self.favoritesViewModel.updateFavoritesList()
    }
}

private extension Selector {
    static let refreshFavorites = #selector(FavoritesListTableViewController.refreshTable)
    static let deletedFavorite = #selector(FavoritesListTableViewController.deletedFavorite)
}

extension NSNotification.Name {
    static let didUpdateFavorites = NSNotification.Name("FavoritesLoaded")
    static let didDeleteFavorite = NSNotification.Name("DeletedFavorite")
}
