//
//  AccountsSectionHeaderPresenter.swift
//  UITableViewPresentation
//
//  Created by Chris Carranza on 5/5/17.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation
import UITableViewPresentation

final class AccountsSectionHeaderPresenter: UITableViewHeaderFooterPresentable {
    let viewReuseIdentifier: String = "AccountsSectionHeader"
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    func configure(view: AccountsSectionHeader, for section: Int) {
        view.titleLabel.text = title
    }
}

extension AccountsSectionHeaderPresenter: UITableViewHeaderFooterNibRegistrable {
    static func == (lhs: AccountsSectionHeaderPresenter, rhs: AccountsSectionHeaderPresenter) -> Bool {
        if lhs.viewReuseIdentifier != rhs.viewReuseIdentifier { return false }
        if lhs.title != rhs.title { return false }
        
        return true
    }
}
