//
//  ChoiseSystem.swift
//  MovieThousand
//
//  Created by Devnull on 9/18/20.
//  Copyright © 2020 Devnull. All rights reserved.
//

import Foundation
import UIKit

public protocol ResubleCell {
    static var reuseIdentifier: String { get }
}

extension UITableView {
    public func dequeue<T: UITableViewCell & ResubleCell>(cell: T.Type, at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath) as! T
    }

    public func dequeue<T: UITableViewCell & ResubleCell>(cell: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: cell.reuseIdentifier) as! T
    }

    public func register<T: UITableViewCell & ResubleCell>(cell: T.Type) {
        register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
    }
}

extension UICollectionView {
    public func dequeue<T: UICollectionViewCell & ResubleCell>(cell: T.Type, at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: cell.reuseIdentifier, for: indexPath) as! T
    }
    public func register<T: UICollectionViewCell & ResubleCell>(cell: T.Type) {
        register(cell, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
}
