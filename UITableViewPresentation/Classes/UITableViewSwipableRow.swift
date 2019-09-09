//
//  UITableViewSwipableRow.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 7/14/17.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation

/// Objects conforming to the `UITableViewSwipableRow` protocol specify
/// whether or not they represent an swipable row. They also specify the
/// `UISwipeActionsConfiguration`s for leading and trailing swipe actions.
@available(iOS 11.0, *)
public protocol UITableViewSwipableRow {
    func leadingSwipeActionsConfiguration() -> UISwipeActionsConfiguration?
    func trailingSwipeActionsConfiguration() -> UISwipeActionsConfiguration?
}

@available(iOS 11.0, *)
extension UITableViewPresentableDataSource {
    public func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let row = tableViewModel[indexPath].base as? UITableViewSwipableRow else { return UISwipeActionsConfiguration() }
        
        return row.leadingSwipeActionsConfiguration()
    }
    
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let row = tableViewModel[indexPath].base as? UITableViewSwipableRow else { return UISwipeActionsConfiguration() }
        
        return row.trailingSwipeActionsConfiguration()
    }
}
