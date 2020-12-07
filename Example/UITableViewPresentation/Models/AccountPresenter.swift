//
//  AccountPresenter.swift
//  UITableViewPresentation
//
//  Created by Chris Carranza on 4/12/17.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation
import UITableViewPresentation

final class AccountPresenter: UITableViewPresentable {
    let id: AnyHashable = UUID()
    
    let account: Account
    let actionDelegate: ExampleActionDelegate
    
    init(account: Account, actionDelegate: ExampleActionDelegate) {
        self.account = account
        self.actionDelegate = actionDelegate
    }
    
    func configure(cell: AccountCell, at indexPath: IndexPath) {
        cell.nameLabel.text = account.name
        cell.idNumberLabel.text = String(account.id)
        cell.accountStatusLabel.text = account.isActive ? "ACTIVE" : "INACTIVE"
        cell.accountStatusView.backgroundColor = account.isActive ? .green : .lightGray
    }
    
    static func == (lhs: AccountPresenter, rhs: AccountPresenter) -> Bool {
        if lhs.cellReuseIdentifier != rhs.cellReuseIdentifier { return false }
        if lhs.account != rhs.account { return false }
        
        return true
    }
}

extension AccountPresenter: UITableViewSwipableRow {
    func leadingSwipeActionsConfiguration(forIndexPath indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return nil
    }
    
    func trailingSwipeActionsConfiguration(forIndexPath indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            UIContextualAction(style: .normal, title: "Do Something", handler: { (_, _, completed) in
                self.actionDelegate.takeAction()
                completed(true)
            })
        ])
    }
}


extension AccountPresenter: UITableViewPrefetchableRow {
    func prefetch(atIndexPath indexPath: IndexPath) {
        print("Prefetch started for \(account.name)")
    }
}
