//
//  UITableViewPrefetchableRow.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 3/9/20.
//

import Foundation

/// Objects conforming to the `UITableViewPrefetchableRow` will opt
/// in to `UITableView` prefetching. They will be notified when they need to
/// start prefetching data and optionally when to cancel prefetching.
public protocol UITableViewPrefetchableRow {
    /// Begin prefetching data
    func prefetch()
    /// Cancel prefetching that may have already been started
    func cancelPrefetch()
}

extension UITableViewPrefetchableRow {
    public func cancelPrefetch() {}
}

extension UITableViewPresentableDataSource: UITableViewDataSourcePrefetching {
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            guard let row = tableViewModel[indexPath].base as? UITableViewPrefetchableRow else { return }
            
            row.prefetch()
        }
    }
    
    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            guard let row = tableViewModel[indexPath].base as? UITableViewPrefetchableRow else { return }
            
            row.cancelPrefetch()
        }
    }
}
