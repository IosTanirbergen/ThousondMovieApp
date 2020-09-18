import UIKit

class DiscoverCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating {

    private let vm = DiscoverViewModel()

    override func viewDidLoad(){
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cell: DiscoverCell.self)

        NotificationCenter.default.addObserver(self, selector: .refreshTable, name: .didUpdateContent, object: nil)

        let viewFavoritesButton = UIBarButtonItem(title: "Favorites", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.viewFavorites(sender:)))
        viewFavoritesButton.image =  UIImage(named: "isFavorite.png")
        self.navigationItem.leftBarButtonItem = viewFavoritesButton

        let rightButton = UIBarButtonItem(title: "List", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.chooseListStyle(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton

        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = search
    }

    // MARK: Collection View

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 5
        return CGSize(width: width, height: width * 1.5)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: DiscoverCell.self, at: indexPath)
        cell.setup(movie: vm.getMovie(at: indexPath))
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.present(DetailViewController(movie: vm.getMovie(at: indexPath)), animated: false, completion: nil)
    }

    @objc func refreshTable() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    @objc func viewFavorites(sender: UIBarButtonItem) {
        self.present(FavoritesListTableViewController(), animated: false, completion: nil)
    }

    // MARK: Search

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        vm.getSearch(with: text)
        refreshTable()
        print(text)
    }

    // MARK: Alert

    @objc func chooseListStyle(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "List Style", message: "Please Select an Option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Now Playing", style: .default, handler: { (_) in
            self.vm.getMovies(endpoint: .nowPlaying)
        }))
        alert.addAction(UIAlertAction(title: "Upcoming", style: .default, handler: { (_) in
            self.vm.getMovies(endpoint: .upcoming)
        }))
        alert.addAction(UIAlertAction(title: "Popular", style: .default, handler: { (_) in
            self.vm.getMovies(endpoint: .popular)
        }))
        alert.addAction(UIAlertAction(title: "Top Rated", style: .default, handler: { (_) in
            self.vm.getMovies(endpoint: .topRated)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
        }))
        self.present(alert, animated: true, completion: {
        })
    }
}

private extension Selector {
    static let refreshTable = #selector(DiscoverCollectionViewController.refreshTable)
}

extension NSNotification.Name {
    static let didUpdateContent = NSNotification.Name("NewContentLoaded")
}
