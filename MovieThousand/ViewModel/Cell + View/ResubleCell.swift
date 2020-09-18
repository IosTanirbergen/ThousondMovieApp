//
//  ResubleCell.swift
//  MovieThousand
//
//  Created by Devnull on 9/18/20.
//  Copyright © 2020 Devnull. All rights reserved.
//

import Foundation
import UIKit

public protocol Resuble {
    static var reuseIdentifier: String { get }
}

extension UITableView {
    /// Returns a reusable cell using it's identifier. The class must be registered prior to being dequeued.
    public func dequeue<T: UITableViewCell & Resuble>(cell: T.Type, at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath) as! T
    }

    /// Returns a reusable cell using it's identifier. The class must be registered prior to being dequeued.
    public func dequeue<T: UITableViewCell & Resuble>(cell: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: cell.reuseIdentifier) as! T
    }

    /// Registers a reusable cell class to be dequeued by the table view.
    public func register<T: UITableViewCell & Resuble>(cell: T.Type) {
        register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
    }
}

extension UICollectionView {
    /// Returns a reusable cell using it's identifier. The class must be registered prior to being dequeued.
    public func dequeue<T: UICollectionViewCell & Resuble>(cell: T.Type, at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: cell.reuseIdentifier, for: indexPath) as! T
    }

    /// Registers a reusable cell class to be dequeued by the collection view.
    public func register<T: UICollectionViewCell & Resuble>(cell: T.Type) {
        register(cell, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
}
