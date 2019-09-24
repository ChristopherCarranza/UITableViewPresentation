//
//  UITableViewEditableRow.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 7/14/17.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import UIKit

/// Objects conforming to the `UITableViewEditableRow` protocol specify 
/// whether or not they represent an editable row. They also specify the 
/// `UITableViewRowAction`s that can be taken when editing the row they 
/// represent.
@available(iOS, deprecated: 10.0, obsoleted: 11.0, message: "Use UITableViewSwipableRow instead")
public protocol UITableViewEditableRow {
    var isEditable: Bool { get }
    func editActions() -> [UITableViewRowAction]?
}

extension UITableViewPresentableDataSource {
    @available(iOS, deprecated: 10.0, obsoleted: 11.0, message: "Use UITableViewSwipableRow instead")
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard let row = tableViewModel[indexPath].base as? UITableViewEditableRow else { return nil }
        
        return row.editActions()
    }
}
