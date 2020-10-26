//
//  UITableViewPrefetchableRow.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 3/9/20.
//

import Foundation

/// Objects conforming to the `UITableViewPrefetchableRow` will opt
/// in to `UITableView` prefetching. They will be notified when they need to
/// start prefetching data.
public protocol UITableViewPrefetchableRow {
    /// Begin prefetching data
    func prefetch(atIndexPath indexPath: IndexPath)
}

extension UITableViewPresentableDataSource: UITableViewDataSourcePrefetching {
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            guard let row = tableViewModel[indexPath].base as? UITableViewPrefetchableRow else { return }
            
            row.prefetch(atIndexPath: indexPath)
        }
    }
}
