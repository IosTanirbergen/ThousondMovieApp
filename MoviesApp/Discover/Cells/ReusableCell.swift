import Foundation
import UIKit

public protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension UITableView {
    /// Returns a reusable cell using it's identifier. The class must be registered prior to being dequeued.
    public func dequeue<T: UITableViewCell & ReusableCell>(cell: T.Type, at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath) as! T
    }

    /// Returns a reusable cell using it's identifier. The class must be registered prior to being dequeued.
    public func dequeue<T: UITableViewCell & ReusableCell>(cell: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: cell.reuseIdentifier) as! T
    }

    /// Registers a reusable cell class to be dequeued by the table view.
    public func register<T: UITableViewCell & ReusableCell>(cell: T.Type) {
        register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
    }
}

extension UICollectionView {
    /// Returns a reusable cell using it's identifier. The class must be registered prior to being dequeued.
    public func dequeue<T: UICollectionViewCell & ReusableCell>(cell: T.Type, at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: cell.reuseIdentifier, for: indexPath) as! T
    }

    /// Registers a reusable cell class to be dequeued by the collection view.
    public func register<T: UICollectionViewCell & ReusableCell>(cell: T.Type) {
        register(cell, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
}
